import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';
import 'package:parky/core/utils/widgets/custom_scaffold_message.dart';
import 'package:parky/features/auth/data/models/register_model.dart';
import 'package:parky/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../../auth/presentation/widgets/custom_drop_down.dart';
import '../widgets/profile_card.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  RegisterModel registerForm = RegisterModel();
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
                        "My Account",
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const ProfileCard(enableEdit: true),
          ),

          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is GetProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // if (state is GetProfileError) {
              //   return Center(
              //     child: Text(state.message),
              //   );
              // }
              return Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "Name",
                          style: getRegularStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        CustomTextFormField(
                          textHint: "Name",
                          colorBorder: Colors.black54,
                          controller: registerForm.firstNameController,
                        ),
                        //email
                        Text(
                          "Email",
                          style: getRegularStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        CustomTextFormField(
                          textHint: "Email",
                          colorBorder: Colors.black54,
                          controller: registerForm.emailController,
                        ),
                        //phone
                        Text(
                          "Phone",
                          style: getRegularStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        CustomTextFormField(
                          textHint: "Phone",
                          colorBorder: Colors.black54,
                          keyboardType: TextInputType.phone,
                          controller: registerForm.phoneController,
                        ),
                        // notional id
                        Text(
                          "National ID",
                          style: getRegularStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        CustomTextFormField(
                          textHint: "National ID",
                          colorBorder: Colors.black54,
                          keyboardType: TextInputType.phone,
                          controller: registerForm.nationalId,
                        ),
                        //gender drop down
                        Text(
                          "Gender",
                          style: getRegularStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        CustomDropDown(
                          gender: registerForm.gender == 'Male'
                              ? Gender.male
                              : Gender.female,
                          onChanged: (value) {
                            if (value == null) return;
                            registerForm.gender == value;
                          },
                        ),

                        SizedBox(height: 24.h),
                        //save button
                        CustomElevatedButton(
                          width: 120.w,
                          height: 28.h,
                          onPressed: () {
                            Navigator.pop(context);
                            showScaffoldMessage(
                              context,
                              message: "Data saved successfully",
                            );
                          },
                          text: "Save data",
                          textColor: Colors.red.shade900,
                          borderColor: Colors.grey,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
