import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/themes/text_style.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController otpController;
  final void Function(String)? onChanged;
  const OtpInputField({super.key, required this.otpController, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      cursor: Text(
        '|',
        style: getRegularStyle(
          color: ColorManager.primaryColor,
          fontSize: 21,
        ),
      ),
      onChanged: onChanged,
      controller: otpController,
      mainAxisAlignment: MainAxisAlignment.center,
      focusedPinTheme: focusedPinTheme,
      defaultPinTheme: defaultPinTheme,
    );
  }

  PinTheme get defaultPinTheme => PinTheme(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        textStyle: getMediumStyle(
          fontSize: 21,
          color: ColorManager.white,
        ),
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: Colors.transparent,
            width: 2.w,
          ),
        ),
      );

  PinTheme get focusedPinTheme => defaultPinTheme.copyDecorationWith(
        border: Border.all(
          // color: ColorManager.lightPrimaryColor,
          width: 2.w,
        ),
      );
}
