import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parky/config/routes/page_name.dart';
import 'package:parky/core/utils/widgets/custom_scaffold_message.dart';

import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../cubit/verify_otp/verify_otp_cubit.dart';

class VerifyOtpButton extends StatelessWidget {
  final bool isRegisterFlow;
  const VerifyOtpButton({super.key, required this.isRegisterFlow});

  @override
  Widget build(BuildContext context) {
    var cubit = VerifyOtpCubit.of(context);
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {},
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is VerifyOtpLoadingState,
          text: "Verify OTP",
          onPressed: () {
            cubit.verifyOtp(isRegisterFlow);
            showScaffoldMessage(context, message: "OTP Verified Successfully");
            Navigator.pushNamedAndRemoveUntil(
              context,
              PageName.loginScreen,
              (route) => false,
            );
          },
        );
      },
    );
  }
}
