import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/core/utils/functions/extensions.dart';

import '../../../../config/themes/text_style.dart';
import '../../constants_manager.dart';
import '../custom_dotted_border.dart';
import '../custom_text.dart';
import 'select_file_button.dart';
import 'upload_file_prefix.dart';
import 'upload_file_title_and_note.dart';

class UploadFileWidget extends StatelessWidget {
  const UploadFileWidget({
    super.key,
    required this.params,
    this.onFileSelected,
    this.enabled = true,
  });

  final UploadFileParams params;
  final Future<void> Function(File? file)? onFileSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: params.errorMessageController.stream,
      builder: (context, snapshot) {
        String? errorMessage = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDottedBorder(
              color: errorMessage != null ? Colors.red : Colors.grey.shade400,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    // Upload icon
                    Expanded(
                      flex: params.isEmpty ? 1 : 2,
                      child: UploadFilePrefix(params: params),
                    ),
                    SizedBox(width: 10.w),

                    // Title, note and select file button
                    Expanded(
                      flex: 4,
                      child: UploadFileTitleAndNote(params: params),
                    ),
                    SizedBox(width: 10.w),

                    // Select file button
                    if (enabled) ...[
                      Expanded(
                        flex: 3,
                        child: SelectFileButton(
                          onFileSelected: (file) async {
                            if (file != null) {
                              params.uploadFile(
                                selectedFile: file,
                                onFileSelected: onFileSelected,
                              );
                            }
                          },
                          isImageFile: params.isImageFile,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Show error message
            if (errorMessage != null) ...{
              CustomText(
                text: errorMessage,
                style: getRegularStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            }
          ],
        );
      },
    );
  }
}

class UploadFileParams {
  /// Used when uploading file is required and a file is selected from device
  File? file;

  /// Used when editing and there is url comes from server
  String? fileUrl;

  /// Used when uploading file is required and no file is selected
  late StreamController<String?> errorMessageController;
  bool isRequired;
  final String title;
  bool inEditMode;
  final List<String> allowedFileExtensions;

  /// Used to determine the valid file type (image or pdf)
  ///
  /// If isImageFile = true, allowed files are images
  ///
  /// If isImageFile = false, allowed files are pdfs
  final bool isImageFile;

  UploadFileParams({
    required this.title,
    this.isRequired = false,
    this.inEditMode = false,
    this.file,
    this.allowedFileExtensions = ConstantsManager.allowedFileExtensions,
    this.fileUrl,
    this.isImageFile = true,
  }) {
    errorMessageController = StreamController<String?>.broadcast();
    errorMessageController.sink.add(null);
  }

  bool get isEmpty => file.isEmpty && (fileUrl == null || fileUrl!.isEmpty);

  String get description {
    // If file is selected and is valid, show file name
    if (validator() == null) {
      return file!.path.split('/').last;
    }

    // Else show upload note
    return "JPG, PNG or PDF, file size no more than 10MB";
  }

  String? validator({File? selectedFile}) {
    // If selected file is not null (user picked file already)
    if (selectedFile != null) {
      // Check if the file size is less than or equal to 10 MB
      if (selectedFile.validSize == false) {
        return "File size should not exceed 10MB";
      }

      // Check if the selected file is valid (within the allowed file extensions)
      final String extension = selectedFile.path.split('.').last.toLowerCase();
      if (!allowedFileExtensions.contains(extension)) {
        return "Invalid file type";
      }

      // If valid extension but does not match the required file type
      if (allowedFileExtensions.contains(extension)) {
        // Check if is image false and file is image
        if (isImageFile == false && _isFileImageType(selectedFile.path)) {
          return "Invalid file type";
        }

        // Check if file is image and the picked file is not an image
        if (isImageFile && !_isFileImageType(selectedFile.path)) {
          return "Invalid file type";
        }
      }
    }

    // If action button pressed and no file selected
    else if (isRequired &&
        selectedFile == null &&
        (fileUrl == null || (fileUrl != null && fileUrl!.isEmpty))) {
      // Add mode
      // Show error message if user didn't select a file
      if (inEditMode == false && file.isEmpty) {
        return "${title.tr()} is required";
      }

      // Edit mode
      // Show error message if user didn't select a file and there is no file url
      if (inEditMode && file.isEmpty && fileUrl != null && fileUrl!.isEmpty) {
        return "${title.tr()} is required";
      }
    }

    return null;
  }

  bool validate() {
    String? errorMessageText = validator();
    errorMessageController.sink.add(errorMessageText);
    return errorMessageText == null;
  }

  void uploadFile({
    required File selectedFile,
    required Future<void> Function(File? file)? onFileSelected,
  }) async {
    String? errorMessageText = validator(selectedFile: selectedFile);
    if (selectedFile.validSize && errorMessageText == null) {
      file = selectedFile;
    }

    if (errorMessageText == null && onFileSelected != null) {
      await onFileSelected(file);
    }
    errorMessageController.sink.add(errorMessageText);
    // // Hide keyboard
    // FocusScope.of(RouteManager.navigatorKey.currentContext!).unfocus();
  }

  /// Check if the file is an image file by checking the file extension
  bool _isFileImageType(String path) {
    final fileExtension = path.split('.').last.toLowerCase();
    return ConstantsManager.imageExtensions.contains(fileExtension);
  }

  void dispose() {
    file = null;
    fileUrl = null;
    errorMessageController.close();
  }
}
