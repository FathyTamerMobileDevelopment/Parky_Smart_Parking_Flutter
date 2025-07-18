import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/core/utils/functions/kprint.dart';

import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/widgets/custom_text.dart';
import '../cubit/verify_otp/verify_otp_cubit.dart';

class ResendComponent extends StatefulWidget {
  // final bool isRegisterFlow;
  const ResendComponent({super.key});

  @override
  State<ResendComponent> createState() => _ResendComponentState();
}

class _ResendComponentState extends State<ResendComponent> {
  late VerifyOtpCubit cubit;
  @override
  void initState() {
    cubit = VerifyOtpCubit.of(context);
    cubit.startTimer();
    super.initState();
  }

  @override
  void dispose() {
    cubit.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listenWhen: (previous, current) => current is ResendOtpErrorState,
      listener: (context, state) {
        if (state is ResendOtpErrorState) {
          // showSnakeBar(msg: state.message, snakeBarType: SnakeBarType.error);
          kprint('ResendOtpErrorState');
        }
      },
      builder: (context, state) {
        var cubit = VerifyOtpCubit.of(context);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cubit.counter > 0) ...[
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Resend after\t",
                      style: getRegularStyle(
                        fontSize: 14,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: _formatCountdown(cubit.counter),
                      style: getMediumStyle(
                        fontSize: 14,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: cubit.counter >= 60 ? '\tminutes' : '\tseconds',
                      style: getRegularStyle(
                        fontSize: 14,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // resend button
            if (cubit.counter == 0) ...[
              InkWell(
                onTap: () {
                  cubit.resendOtp();
                },
                child: CustomText(
                  text: 'Resend',
                  style: getMediumStyle(
                    fontSize: 16,
                    color: ColorManager.primaryColor,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
            if (state is ResendOtpLoadingState) ...[
              const CircularProgressIndicator(),
            ]
          ],
        );
      },
    );
  }
}

String _formatCountdown(int seconds) {
  // convert seconds to minutes and remaining seconds
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;

  // return formatted string
  return '${minutes < 10 ? '0' : ''}$minutes:${remainingSeconds < 10 ? '0' : ''}$remainingSeconds';
}
