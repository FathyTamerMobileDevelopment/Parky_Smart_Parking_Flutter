import 'package:flutter/material.dart';
import 'package:parky/config/routes/page_name.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_svg_icon.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../../../core/helpers/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // await HomeCubit.get(context).getLocation();

    await Future.delayed(const Duration(seconds: 4));

    // token
    String? token = CacheHelper.getStringData('token');

    if (token == null) {
      Navigator.pushReplacementNamed(context, PageName.onBoarding1);
    } else {
      Navigator.pushReplacementNamed(context, PageName.layoutScreen);
    }

    // await HomeCubit.get(context).getParkings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomSvgIcon(
              iconPath: AssetsManager.logo,
              width: 250,
              height: 110,
            ),
            CustomText(
              text: 'Smart Parking',
              style: getRegularStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
