import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';
import 'package:parky/config/themes/assets_manager.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_manager.dart';
import 'package:parky/config/themes/text_style.dart';

class NoConnectionScreen extends StatelessWidget {
  final Function? onRetry;
  const NoConnectionScreen({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsManager.noConnection,
            colorFilter: const ColorFilter.mode(
              ColorManager.black,
              BlendMode.srcIn,
            ),
          ),
          CustomText(
            text: TextManager.noInternet,
            style: getBoldStyle(fontSize: 22.sp),
          ),
        ],
      ),
    );
  }
}
