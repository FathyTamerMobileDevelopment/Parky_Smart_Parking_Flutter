import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../../../config/themes/color_manager.dart';
import '../../../../config/themes/text_style.dart';

class CustomVipImage extends StatelessWidget {
  const CustomVipImage({
    super.key,
    required this.isShape2,
    this.onTap,
    required this.isSelected,
  });
  final bool isShape2;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(
            width: 0.9.sw,
            child: Image.asset(
              isShape2 ? AssetsManager.parkingVip2 : AssetsManager.parkingVip,
              height: 0.2.sh,
              fit: BoxFit.fill,
            ),
          ),
          if (isSelected)
            Positioned(
              top: 0.1.sh,
              left: isShape2 ? null : 0.46.sw,
              child: Container(
                color: Colors.white,
                child: Text(
                  'Sellected',
                  style: getBoldStyle(
                    fontSize: 16,
                    color: ColorManager.primaryColor,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
