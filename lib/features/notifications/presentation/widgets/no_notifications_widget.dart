import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/widgets/custom_svg_icon.dart';
import '../../../../core/utils/widgets/custom_text.dart';

class NoNotificationsWidget extends StatelessWidget {
  const NoNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 120.h,
          width: 120.w,
          child: const CustomSvgIcon(iconPath: AssetsManager.noNotifications),
        ),
        CustomText(
          text: "Sorry, there are no notifications!",
          style: getBoldStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        CustomText(
          text: "Your notifications will appear here once received.",
          style: getBoldStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
