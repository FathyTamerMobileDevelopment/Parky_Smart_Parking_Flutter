import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/routes/page_name.dart';
import 'package:parky/core/utils/widgets/custom_text_form_field.dart';
import 'package:parky/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../../../core/utils/widgets/custom_scaffold_message.dart';
import '../../../../core/utils/widgets/upload_file/upload_file_widget.dart';
import '../../data/models/register_model.dart';
import '../widgets/custom_app_bar.dart';

class CompleteSignUpScreen extends StatelessWidget {
  const CompleteSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showScaffoldMessage(
            context,
            message: "Register Successfully",
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageName.loginScreen,
            (route) => false,
          );
        }
        if (state is RegisterError) {
          showScaffoldMessage(
            context,
            message: state.message,
            type: ErrorType.error,
          );
        }
      },
      builder: (context, state) {
        RegisterModel registerForm = AuthCubit.get(context).registerForm;
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
                title: 'Complete Sign Up',
                onBack: () {
                  Navigator.pop(context);
                },
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Form(
                    key: registerForm.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Car Model",
                              style: getRegularStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            CustomTextFormField(
                              controller: registerForm.carModelController,
                              textHint: "Car Model",
                              colorBorder: Colors.black54,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Car Number",
                                  style: getRegularStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                CustomTextFormField(
                                  controller:
                                      registerForm.licensePlateController,
                                  textHint: "أ ب ت 1 2 3",
                                  colorBorder: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        UploadFileWidget(
                          params: UploadFileParams(title: "Upload Car License"),
                          // enabled: true,
                        ),
                        SizedBox(height: 33.h),
                        CustomElevatedButton(
                          isLoading: state is RegisterLoading,
                          onPressed: () {
                            // Navigator.pushNamed(context, PageName.otpScreen);
                            if (registerForm.formKey.currentState!.validate()) {
                              AuthCubit.get(context).register();
                            }
                          },
                          text: "Sign Up",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
