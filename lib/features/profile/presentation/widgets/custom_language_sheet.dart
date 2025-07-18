import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/text_manager.dart';
import 'package:parky/core/utils/widgets/custom_radio_button.dart';
import 'package:parky/core/utils/widgets/custom_svg_icon.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../../../config/themes/text_style.dart';

class CustomLanguageSheet extends StatefulWidget {
  const CustomLanguageSheet({super.key});

  @override
  State<CustomLanguageSheet> createState() => _CustomLanguageSheetState();
}

class _CustomLanguageSheetState extends State<CustomLanguageSheet> {
  void _changeLanguage(Locale locale) {
    context.setLocale(locale); // تغيير اللغة باستخدام easy_localization
    setState(() {}); // تحديث الواجهة
  }

  String selectedLanguage = 'en';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.cancel_outlined,
                size: 30.sp,
              ),
            ),
          ),
          // chage language
          Text(
            TextManager.changeLanguage.tr(),
            style: getBoldStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text(
            TextManager.changeLanguageSubTitle.tr(),
            style: getBoldStyle(
              fontSize: 16,
              color: Colors.black45,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              children: [
                const CustomSvgIcon(iconPath: AssetsManager.enFlag),
                SizedBox(width: 10.w),
                Text(
                  'English',
                  style: getBoldStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                CustomRadioButton(
                  value: const Locale('en').languageCode,
                  groupValue: context.locale.languageCode,
                  onChanged: (value) {
                    if (value != null) {
                      _changeLanguage(Locale(value));
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              children: [
                const CustomSvgIcon(iconPath: AssetsManager.arFlag),
                SizedBox(width: 10.w),
                Text(
                  'العربية',
                  style: getBoldStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                CustomRadioButton(
                  value: const Locale('ar').languageCode,
                  groupValue: context.locale.languageCode,
                  onChanged: (value) {
                    // kprint(value);
                    if (value != null) {
                      _changeLanguage(Locale(value));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
