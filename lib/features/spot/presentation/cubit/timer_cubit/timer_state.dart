part of 'timer_cubit.dart';

sealed class TimerState {}

final class TimerInitial extends TimerState {}

final class TimerRunInProgress extends TimerState {
  final int timeLeft;
  TimerRunInProgress(this.timeLeft);
}

final class TimerRunComplete extends TimerState {}

final class TimerStopped extends TimerState {}
