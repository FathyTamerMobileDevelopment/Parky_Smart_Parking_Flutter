import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  static TimerCubit get(context) => BlocProvider.of(context);
  Timer? _timer;
  int waitingTime = 0;
  int currentTime = 0;
  bool isTimerStart = false;
  double costOfSpot = 0;

  TimerCubit() : super(TimerInitial());

  void startTimer(
      {required int waitingDurationSecends,
      required int currentDurationSecends}) {
    isTimerStart = true;

    _timer?.cancel();
    emit(TimerRunInProgress(waitingDurationSecends));
    waitingTime = waitingDurationSecends;
    currentTime = currentDurationSecends;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      waitingTime--;
      if (waitingTime > 0) {
        emit(TimerRunInProgress(waitingTime));
      } else {
        timer.cancel();
        emit(TimerRunComplete());
        _startTimerCurrentTime(durationInSeconds: currentDurationSecends);
      }
    });
  }

  // start cuurent time
  void _startTimerCurrentTime({required int durationInSeconds}) {
    _timer?.cancel();
    emit(TimerRunInProgress(durationInSeconds));
    currentTime = durationInSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // isTieWaitingRun = true;
      currentTime--;
      if (currentTime >= 0) {
        emit(TimerRunInProgress(currentTime));
      } else {
        isTimerStart = false;
        timer.cancel();
        emit(TimerRunComplete());
      }
    });
  }

  void stopTimer() {
    isTimerStart = false;
    _timer?.cancel();
    emit(TimerStopped());
  }

  // add more current time
  void addCurrentTime({required int durationInSeconds}) {
    currentTime += durationInSeconds;
    _timer?.cancel();
    emit(TimerRunComplete());
    _startTimerCurrentTime(durationInSeconds: currentTime);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
