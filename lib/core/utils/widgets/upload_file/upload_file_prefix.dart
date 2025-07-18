import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/core/utils/functions/extensions.dart';

import '../../../../config/themes/assets_manager.dart';
import '../custom_svg_icon.dart';
import 'file_icon.dart';
import 'upload_file_widget.dart';

class UploadFilePrefix extends StatelessWidget {
  final UploadFileParams params;

  /// Shows upload file icon, uploaded file icon or image itself
  const UploadFilePrefix({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    if (params.isEmpty) {
      return CustomSvgIcon(
        iconPath: AssetsManager.upload,
        width: 50.w,
        height: 50.h,
        color: Theme.of(context).iconTheme.color!,
      );
    }

    return AspectRatio(
      aspectRatio: 1,
      child: child,
    );
  }

  Widget get child {
    // If selected file size is valid
    if (params.file.validSize) {
      // If selected file is image
      if (params.isImageFile) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.file(
            params.file!,
            fit: BoxFit.cover,
          ),
        );
      }

      // If selected file is not image
      return const FileIcon();
    }

    // If there is no file selected but there is an image url
    if (params.fileUrl != null) {
      if (params.isImageFile) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: CachedNetworkImage(
            imageUrl: params.fileUrl!,
            fit: BoxFit.cover,
          ),
        );
      }

      return const FileIcon();
    }

    // If there is no file selected nor image url
    return const FileIcon();
  }
}
