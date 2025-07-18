import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/text_style.dart';

import '../../../../config/themes/assets_manager.dart';
import '../cubit/verify_otp/verify_otp_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/resend_component.dart';
import '../widgets/verify_otp_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyOtpCubit(),
      child: Builder(builder: (context) {
        var cubit = VerifyOtpCubit.of(context);

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
              appBar: customAppBar(
                title: 'Email Verification',
                onBack: () {
                  Navigator.pop(context);
                },
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        "Email Verification",
                        style: getBoldStyle(
                          fontSize: 28,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Enter the verification code we just sent on your email address.",
                        style: getRegularStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // verticalSpace(24),
                      SizedBox(height: 24.h),
                      // OTP Input
                      OtpInputField(
                        otpController: cubit.otpController,
                        onChanged: (_) {
                          cubit.emitOtpChanged();
                        },
                      ),

                      SizedBox(height: 16.h),

                      // Resend Component
                      const ResendComponent(),
                      SizedBox(height: 33.h),
                      const VerifyOtpButton(
                        isRegisterFlow: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
