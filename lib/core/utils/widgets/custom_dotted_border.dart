import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';

class CustomDottedBorder extends StatelessWidget {
  final Widget child;
  final Color? color;
  const CustomDottedBorder({
    super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: EdgeInsets.zero,
      borderType: BorderType.RRect,
      color: color ?? ColorManager.primaryColor,
      dashPattern: const [8, 4],
      radius: Radius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: child,
      ),
    );
  }
}
