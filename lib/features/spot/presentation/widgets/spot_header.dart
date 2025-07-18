import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';

import 'spot_drop_down.dart';

class SpotHeader extends StatelessWidget {
  const SpotHeader({super.key, this.onChanged});
  final dynamic Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .13.sh,
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                text: 'Parking',
                style: getBoldStyle(fontSize: 13, color: Colors.black),
              ),
              const Spacer(),
              CustomText(
                text: '20/24 OPEN',
                style: getBoldStyle(
                    fontSize: 13, color: ColorManager.primaryColor),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              const Expanded(child: SpotDropDown()),
              SizedBox(width: 20.w),
              Expanded(
                child: SpotDropDown(
                  isFloor: false,
                  onChanged: onChanged,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
