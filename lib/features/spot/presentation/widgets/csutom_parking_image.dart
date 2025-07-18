import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../../../config/themes/text_style.dart';

// bool genenralSelected = false;

class CsutomParkingImage extends StatelessWidget {
  const CsutomParkingImage({
    super.key,
    this.isParing1 = false,
    this.onTap,
    required this.isSelected,
  });
  final bool isParing1;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Stack(
        children: [
          Image.asset(
            isParing1 ? AssetsManager.parking1 : AssetsManager.parking2,
            height: 0.4.sh,
            fit: BoxFit.fill,
          ),
          if (isSelected)
            Positioned(
              bottom: isParing1 ? null : 0.1.sh,
              top: isParing1 ? 0.1.sh : null,
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.primaryColor,
                  ),
                  color: Colors.white,
                ),
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
