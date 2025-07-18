import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/themes/text_style.dart';
import 'widgets/custom_elevated_button.dart';
import 'widgets/custom_text.dart';

void showCustomAlertDialoge({
  required String title,
  String? content,
  int size = 87,
  required BuildContext context,
  String? icon,
  String? animation,
  String? firstButtonName,
  String? secondButtonName,
  Function()? firstButtonFunction,
  Function()? secondButtonFunction,
  bool? isSvg = true,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsetsDirectional.only(bottom: 32.h),
        title: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                top: 32.h,
                start: 32.w,
                end: 32.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h),
                  if (animation != null) ...{
                    Lottie.asset(animation,
                        width: 117.w, height: 129.h, fit: BoxFit.contain),
                    SizedBox(height: 24.h),
                  },
                  if (icon != null) ...{
                    isSvg!
                        ? SvgPicture.asset(
                            icon,
                            width: 145.w,
                            height: 127.h,
                          )
                        : Image.asset(
                            icon,
                            width: 145.w,
                            height: 127.h,
                          ),
                    SizedBox(height: 24.h),
                  },
                  CustomText(
                    text: title,
                    style: getSemiBoldStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (content != null) ...{
                    SizedBox(height: 20.h),
                    CustomText(
                      text: content,
                      style: getRegularStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  },
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    children: [
                      if (firstButtonName != null) ...{
                        Flexible(
                          child: FittedBox(
                            child: CustomElevatedButton(
                              text: firstButtonName,
                              onPressed: firstButtonFunction ??
                                  () {
                                    Navigator.pop(context);
                                  },
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                      },
                      if (secondButtonName != null) ...{
                        Flexible(
                          child: FittedBox(
                            child: CustomElevatedButton(
                              text: secondButtonName,
                              onPressed: secondButtonFunction ??
                                  () {
                                    Navigator.pop(context);
                                  },
                            ),
                          ),
                        ),
                      }
                    ],
                  )
                ],
              ),
            ),
            PositionedDirectional(
              top: 28.h,
              start: 10.w,
              child: const CloseButton(),
            ),
          ],
        ),
      );
    },
  );
}
