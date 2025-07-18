import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/routes/page_name.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';
import 'package:parky/core/utils/widgets/custom_scaffold_message.dart';
import 'package:parky/core/utils/widgets/custom_text_form_field.dart';
import 'package:parky/features/auth/data/models/register_model.dart';
import 'package:parky/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../config/themes/assets_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  RegisterModel registerModel = RegisterModel();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showScaffoldMessage(
            context,
            message: "Login Successfully",
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageName.layoutScreen,
            (route) => false,
          );
        }
        if (state is LoginError) {
          showScaffoldMessage(
            context,
            message: state.message,
            type: ErrorType.error,
          );
        }
      },
      builder: (context, state) {
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
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.5.sh),
                      Text(
                        "Sign In",
                        style: getBoldStyle(
                          fontSize: 34,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Hi ! Welcome back, you've been missed",
                        style: getBoldStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: registerModel.emailController,
                        textHint: "Email",
                        textColor: Colors.white,
                      ),
                      CustomTextFormField(
                        controller: registerModel.passwordController,
                        textHint: "password",
                        textColor: Colors.white,
                        obscureText: obscureText,
                        isSuffixWidget: true,
                        passwordVisibility: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomElevatedButton(
                        isLoading: state is LoginLoading,
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          AuthCubit.get(context).login();
                        },
                        text: "Log In",
                        height: 40,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: getRegularStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageName.signUpScreen);
                            },
                            child: Text(
                              "Sign Up",
                              style: getRegularStyle(
                                color: ColorManager.primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 80),
                    ],
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
