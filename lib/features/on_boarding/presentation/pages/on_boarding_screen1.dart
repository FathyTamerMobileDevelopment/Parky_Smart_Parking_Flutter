import 'package:flutter/material.dart';
import 'package:parky/config/themes/assets_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';

import '../../../../config/routes/page_name.dart';

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManager.onBoarding1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Find The Best Car Parking Spot",
                style: getBoldStyle(
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Find the best parking spot, every time, without the hassle",
                style: getBoldStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(PageName.onBoarding2);
                },
                text: "Let's get started",
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
