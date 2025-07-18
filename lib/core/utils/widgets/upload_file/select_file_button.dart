import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parky/config/themes/color_manager.dart';

import '../../../helpers/file_picker/file_picker_helper.dart';
import '../custom_elevated_button.dart';

class SelectFileButton extends StatelessWidget {
  const SelectFileButton({
    super.key,
    this.onFileSelected,
    required this.isImageFile,
  });

  final Future<void> Function(File? file)? onFileSelected;
  final bool isImageFile;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      borderRadius: 10,
      height: 45,
      onPressed: () async {
        final file = await FilePickerHelper.selectFile();
        if (file != null && onFileSelected != null) {
          onFileSelected!(file);
        }
      },
      text: "Select File",
      backgroundColor: Colors.white,
      textColor: ColorManager.primaryColor,
      size: 13,
      borderColor: ColorManager.primaryColor,
    );
  }
}
