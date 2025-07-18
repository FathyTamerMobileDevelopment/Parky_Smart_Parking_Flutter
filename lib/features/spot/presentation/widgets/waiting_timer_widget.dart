import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/functions/formate_duration.dart';
import '../../../../core/utils/widgets/custom_text.dart';
import '../cubit/timer_cubit/timer_cubit.dart';

class WaitingTimerWidget extends StatelessWidget {
  const WaitingTimerWidget({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerCubit, TimerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var timerCubit = TimerCubit.get(context);
        String time = "00:00:00";
        if (state is TimerRunInProgress) {
          time = formatDuration(timerCubit.waitingTime);
        }
        return CustomText(
          text: "it will be start after ⌛️ $time",
          style: getBoldStyle(
            fontSize: 14,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
