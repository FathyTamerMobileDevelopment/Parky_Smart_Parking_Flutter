import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';

import '../../../config/themes/text_style.dart';
import 'custom_text.dart';

enum ErrorType { success, error }

showScaffoldMessage(
  BuildContext context, {
  String? message,
  ErrorType type = ErrorType.success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0.8.sh),
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      elevation: 0,
      content: Container(
        // margin: EdgeInsets.only(bottom: 0.8.sh),
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == ErrorType.success ? Icons.check : Icons.error,
              color:
                  type == ErrorType.success ? ColorManager.white : Colors.red,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomText(
                text: message ?? "Will comming soon",
                style: getMediumStyle(
                  color: type == ErrorType.success
                      ? ColorManager.white
                      : Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
