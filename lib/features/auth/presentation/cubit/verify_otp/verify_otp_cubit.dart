import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/functions/kprint.dart';

part 'verify_otp_states.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitialState());

  static VerifyOtpCubit of(context) => BlocProvider.of<VerifyOtpCubit>(context);
  final TextEditingController otpController = TextEditingController();

  int counter = 0;
  Timer? timer;

  void emitOtpChanged() {
    emit(OtpChangedState());
  }

  void startTimer() {
    stopTimer();

    counter = 120; // 2 minutes

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (counter > 0) {
          counter--;
          emit(TimerState());
        } else {
          stopTimer();
        }
      },
    );
  }

  void stopTimer() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
      counter = 0;
      kprint("Timer Cancelled");
      emit(TimerState());
    }
  }

  Future<void> resendOtp() async {
    // emit(ResendOtpLoadingState());

    startTimer();
    // emit(ResendOtpSuccessState());
  }

  void verifyOtp(bool isRegisterFlow) async {
    // emit(VerifyOtpLoadingState());

    otpController.clear();
    stopTimer();
    // emit(VerifyOtpSuccessState(message: 'Success'));
  }
}
