part of 'verify_otp_cubit.dart';

abstract class VerifyOtpState {}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpLoadingState extends VerifyOtpState {}

class VerifyOtpSuccessState extends VerifyOtpState {
  final String message;

  VerifyOtpSuccessState({required this.message});
}

class VerifyOtpFailureState extends VerifyOtpState {
  final String message;

  VerifyOtpFailureState({required this.message});
}

class OtpChangedState extends VerifyOtpState {}

class TimerState extends VerifyOtpState {}

class ResendOtpLoadingState extends VerifyOtpState {}

class ResendOtpSuccessState extends VerifyOtpState {}

class ResendOtpErrorState extends VerifyOtpState {
  final String message;

  ResendOtpErrorState(this.message);
}
