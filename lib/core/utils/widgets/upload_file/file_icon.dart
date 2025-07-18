import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/themes/assets_manager.dart';

class FileIcon extends StatelessWidget {
  final String icon;
  const FileIcon({
    super.key,
    this.icon = AssetsManager.pdfFile,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: 50.w,
      height: 50.h,
    );
  }
}
