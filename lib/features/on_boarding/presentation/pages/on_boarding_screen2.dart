import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';
import 'package:parky/core/utils/widgets/dots.dart';

import '../../../../config/routes/page_name.dart';
import '../../../../config/themes/assets_manager.dart';
import '../../domain/entities/on_boarding_entity.dart';

class OnBoardingScreen2 extends StatefulWidget {
  const OnBoardingScreen2({super.key});

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<OnBoardingScreen2> {
  int currentIndex = 0;

  List<OnBoardingEntity> onBoardingList = [
    OnBoardingEntity(
      image: AssetsManager.onBoarding2,
      title: "Never Lose Your Perfect Parking Spot Again",
      subtitle: "Save your favorite parking spots for later",
    ),
    OnBoardingEntity(
      image: AssetsManager.onBoarding3,
      title: "Track your parking booking the easy way!",
      subtitle: "The Easiest Way to track Your Parking Booking",
    ),
    OnBoardingEntity(
      image: AssetsManager.onBoarding4,
      title: "Find Nearby Parking Spots with Ease",
      subtitle: "Discover parking spots nearby effortlessly.",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManager.onBoardingBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Image.asset(
                onBoardingList[currentIndex].image,
                height: .6.sh,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20.h),
              Text(
                onBoardingList[currentIndex].title,
                style: getBoldStyle(
                  fontSize: 26,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                onBoardingList[currentIndex].subtitle,
                style: getRegularStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.h),
              Dots(
                numberOfDots: 3,
                currentIndex: currentIndex,
              ),
              SizedBox(height: 28.h),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (currentIndex != 0) ...{
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorManager.primaryColor,
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                currentIndex--;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 38.sp,
                              color: ColorManager.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                      },
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () {
                            if (currentIndex < onBoardingList.length - 1) {
                              setState(() {
                                currentIndex++;
                              });
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed(PageName.loginScreen);
                            }
                          },
                          text: 'Next',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
