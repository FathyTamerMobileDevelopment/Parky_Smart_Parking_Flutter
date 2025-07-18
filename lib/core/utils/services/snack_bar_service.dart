import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:parky/config/themes/color_manager.dart';

import '../../../config/themes/text_style.dart';
import '../widgets/custom_text.dart';

// don't forget to generate bot_toast in MaterialApp.  => mostafa
enum SnakeBarType { success, error }

void showSnakeBar({
  required String msg,
  required SnakeBarType snakeBarType,
}) {
  BotToast.showCustomNotification(
    toastBuilder: (void Function() cancelFunc) {
      return Material(
        color: Colors.transparent,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsetsDirectional.only(end: 8.w),
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            // color: Colors.white60,
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IntrinsicHeight(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: snakeBarType == SnakeBarType.success
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Lottie.asset(
                    snakeBarType == SnakeBarType.success
                        ? "assets/icons/face_success_icon.json"
                        : "assets/icons/face_wrong_icon.json",
                    repeat: false,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snakeBarType == SnakeBarType.success
                              ? "Success"
                              : "Error",
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          style: getSemiBoldStyle(
                            fontSize: 18,
                            color: snakeBarType == SnakeBarType.success
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 5.w, top: 5.h),
                          child: CustomText(
                            text: msg,
                            textAlign: TextAlign.start,
                            style: getRegularStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.black54,
                  thickness: 2,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: cancelFunc,
                    child: Text(
                      "close",
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    duration: const Duration(
      seconds: 4,
    ),
    dismissDirections: [DismissDirection.endToStart],
  );
}
