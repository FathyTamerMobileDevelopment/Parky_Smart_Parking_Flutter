import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';
import 'package:parky/core/utils/widgets/custom_text_form_field.dart';
import 'package:parky/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../../../config/themes/color_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../widgets/custom_family_card.dart';

class FamilyComunityScreen extends StatelessWidget {
  const FamilyComunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          // app bar
          Container(
            color: ColorManager.primaryColor,
            height: 0.17.sh,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AssetsManager.onBoardingBg,
                  color: Colors.white,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back,
                            color: Colors.white, size: 30.sp),
                      ),
                      const Spacer(),
                      Text(
                        "Family Comunity",
                        style: getMediumStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      const CustomTextFormField(
                        textHint: 'Invite by email...',
                        colorBorder: ColorManager.grey2,
                        fillColor: ColorManager.lightGrey,
                        hintColor: ColorManager.grey2,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Invite',
                          style:
                              getMediumStyle(color: ColorManager.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return const CustomFamilyCard(isInviteCard: true, id: -1);
                    },
                  ),
                  CustomText(
                    text: "Your Family",
                    style:
                        getBoldStyle(fontSize: 16, color: ColorManager.black),
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      var familyList = ProfileCubit.get(context).familyList;
                      if (familyList.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Your family list is empty",
                              style: getBoldStyle(
                                fontSize: 18,
                                color: ColorManager.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: familyList.length,
                        itemBuilder: (context, index) {
                          return CustomFamilyCard(
                            id: familyList[index],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
