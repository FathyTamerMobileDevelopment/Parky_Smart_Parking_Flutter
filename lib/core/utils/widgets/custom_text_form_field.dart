import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? textHint;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? prefixIcon;
  final Icon? suffixIcon;
  final bool obscureText;
  final bool suffix;
  final bool isSuffixWidget;
  final Color textColor;
  final Widget? suffixWidget;
  final String? Function(String?)? validator;
  final Function(String?)? onchangeFun;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool hasBorder;
  final Color fillColor;
  final int maxLength;
  final double fontSize;
  final bool isEn;
  final Function? onEditingComplete;
  final Color colorBorder;
  final Color hintColor;
  final Function? passwordVisibility;
  final int maxLines;
  final bool enabled;
  final void Function(String)? onFieldSubmitted;
  final double verticalPadding;

  const CustomTextFormField({
    super.key,
    this.label,
    this.textHint,
    this.textColor = ColorManager.black,
    this.hintColor = ColorManager.grey3,
    this.maxLines = 4,
    this.onchangeFun,
    this.passwordVisibility,
    this.isSuffixWidget = false,
    this.suffixWidget,
    this.suffix = false,
    this.width,
    this.borderRadius = 12,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onEditingComplete,
    this.enabled = true,
    this.colorBorder = ColorManager.white,
    this.hasBorder = true,
    this.fillColor = ColorManager.transparent,
    this.maxLength = 10000,
    this.fontSize = 16,
    this.isEn = false,
    this.height = 40,
    this.onFieldSubmitted,
    this.verticalPadding = 8,
  });

  @override
  Widget build(BuildContext context) {
    String updatedHintText = textHint == null ? "" : context.tr(textHint!);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,

        enabled: enabled,
        keyboardType: keyboardType,
        // cursorHeight: 25.h,
        cursorColor: ColorManager.primaryColor,
        // maxLines: maxLines,
        // minLines: 1,
        style: getMediumStyle(
          fontSize: fontSize,
          color: textColor,
        ),

        onChanged: onchangeFun,
        controller: controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        obscureText: obscureText,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'field is required';
              }
              return null;
            },
        decoration: InputDecoration(
          hintStyle: getRegularStyle(
            fontSize: 16,
            color: hintColor,
          ),

          alignLabelWithHint: true,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: colorBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: colorBorder,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: colorBorder,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          suffix: suffixWidget,
          suffixIcon: isSuffixWidget
              ? IconButton(
                  onPressed: () {
                    passwordVisibility!();
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                )
              : null,
          fillColor: fillColor,
          label: label == null
              ? null
              : CustomText(
                  text: label!,
                  style: getRegularStyle(
                    fontSize: 16,
                    color: ColorManager.primaryColor,
                  ),
                  textAlign: TextAlign.start,
                ),
          hintText: updatedHintText,
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPadding.h,
            horizontal: 16.w,
          ),
          //hintMaxLines: 1,
          prefixIcon: prefixIcon,
          suffixStyle: getRegularStyle(
            fontSize: 14,
            color: ColorManager.primaryColor,
          ),
        ),
        // control the number of digits in the text field
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
      ),
    );
  }
}
