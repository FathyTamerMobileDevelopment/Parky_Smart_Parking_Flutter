import 'dart:io';

// import 'package:ffmpeg_helper/ffmpeg_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/functions/kprint.dart';

abstract class FilePickerHelper {
  // static Future<String> _convertMovToMp4(String inputPath) async {
  //   String outputPath = inputPath.replaceAll(RegExp(r'\.\w+$'), '.MP4');

  //   await FFmpegKit.execute(
  //           '-i "$inputPath" -c:v h264 -c:a aac "$outputPath"')
  //       .then((session) async {
  //     final returnCode = await session.getReturnCode();
  //     if (ReturnCode.isSuccess(returnCode)) {
  //       print("Conversion successful: $outputPath");
  //       return outputPath;
  //     } else {
  //       print("Conversion failed.");
  //       return inputPath;
  //     }
  //   });

  //   return outputPath;
  // }

  static File? _checkImageFileSize({required File uploadedFile}) {
    num fileSizeInMb = uploadedFile.lengthSync() / (1024 * 1024);
    kprint("File Size in MB: $fileSizeInMb");
    if (fileSizeInMb >= 10) {
      // showSnakeBar(
      //     msg:
      //         "${TextManager.imageSizeShouldBeLessThan.tr()} ${ConstantsManager.maxFileSize} ${TextManager.mb.tr()}",
      //     snakeBarType: SnakeBarType.error);
      // showScaffoldMessage(context, message: "Image size should be less than 10 MB");
      return null;
    }
    return uploadedFile;
  }

  static Future<File?> selectImage({
    required ImageSource source,
  }) async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: source);

      File? file;

      if (pickedFile != null) {
        file = _checkImageFileSize(uploadedFile: File(pickedFile.path));
      }
      return file;
    } catch (_) {
      // showSnakeBar(
      //     msg: TextManager.thereisAProblemInUploadingTheImage,
      //     snakeBarType: SnakeBarType.error);
    }
    return null;
  }

  static Future<XFile?> selectVideo({
    required ImageSource source,
  }) async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.pickVideo(source: source);

      XFile? file;

      if (pickedFile != null) {
        String filePath = pickedFile.path;
        // if (filePath.contains('.mov') || filePath.contains('.MOV')) {
        //   filePath = await _convertMovToMp4(filePath);
        // }
        file = XFile(filePath);
      }

      return file;
    } catch (e) {
      kprint(e.toString());
      // showSnakeBar(
      //     msg: TextManager.thereIsAProblemInUploadingTheVideo,
      //     snakeBarType: SnakeBarType.error);
    }
    return null;
  }

  static Future<File?> selectFile() async {
    final picker = FilePicker.platform;

    final pickedFile = await picker.pickFiles();

    File? file;

    if (pickedFile != null) {
      file = File(pickedFile.files.single.path!);
    }

    return file;
  }
}
