import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/responsive_methods.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';
import 'package:parky/core/utils/widgets/spinket_loader.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final TextStyle? style;
  final String text;
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final double width;
  final double height;
  final bool shadow;
  final bool isDisabled;
  final bool isLoading;
  final AlignmentGeometry buttonAlignment;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.style,
    this.buttonAlignment = Alignment.center,
    this.width = 1,
    this.shadow = false,
    this.height = 50,
    this.borderRadius = 16,
    this.borderColor = ColorManager.primaryColor,
    required this.text,
    this.textColor = ColorManager.white,
    this.backgroundColor = ColorManager.primaryColor,
    this.size = 16,
    this.isDisabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SpinketLoader();
    }

    return SizedBox(
      height: isTablet(context) ? 60.h : height.h,
      width: width == 1 ? width.sw : width.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? ColorManager.grey2 : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor,
              width: 1.5.sp,
            ),
          ),
          elevation: shadow ? 5 : 0,
        ),
        // style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        //       backgroundColor: WidgetStateProperty.all<Color>(
        //           isDisabled ? ColorManager.grey2 : backgroundColor),
        //       side: WidgetStatePropertyAll(
        //         BorderSide(
        //           color: ColorManager.transparent,
        //           width: 1.5.sp,
        //         ),
        //       ),
        //     ),
        onPressed: isDisabled ? null : onPressed,
        child: CustomText(
          text: text,
          style: style ??
              getBoldStyle(
                fontSize: isTablet(context) ? 8.sp : size.sp,
                color: textColor,
              ),
        ),
      ),
    );
  }
}
