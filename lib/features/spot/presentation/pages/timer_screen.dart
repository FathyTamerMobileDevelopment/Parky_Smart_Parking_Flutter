import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';
import 'package:parky/features/wallet/data/models/wallet_model.dart';

import '../../../../config/themes/color_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/services/snack_bar_service.dart';
import '../../../wallet/data/models/translation_model.dart';
import '../../../wallet/presentation/cubit/wallet_cubit.dart';
import '../cubit/timer_cubit/timer_cubit.dart';
import '../widgets/current_time_widget.dart';
import '../widgets/waiting_timer_widget.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  void initState() {
    super.initState();
    var timerCubit = TimerCubit.get(context);
    if (timerCubit.isTimerStart == false) {
      timerCubit.startTimer(
        waitingDurationSecends: 30,
        // houre in secends
        // 1 houre in secends = 3600
        currentDurationSecends: 3600,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var timerCubit = TimerCubit.get(context);
    WalletModel walletModel = WalletModel.instance;
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Column(
        children: [
          // app bar
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            height: 0.17.sh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      // size: 12,
                      color: ColorManager.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Track Your Reservation",
                  style: getBoldStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  // overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    const CurrentTimeWidget(),
                    CustomText(
                      text: "left until your reservation expires",
                      style: getRegularStyle(
                        fontSize: 16,
                        color: ColorManager.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 0.4.sh),

                    const WaitingTimerWidget(),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            backgroundColor: ColorManager.grey2,
                            onPressed: () {
                              // show dialog to comfim this action
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("End reservation"),
                                    content: const Text(
                                        "Are you sure you want to end your reservation?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          TimerCubit.get(context).stopTimer();
                                          for (var i = 0; i < 3; i++) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("Confirm"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            text: "End reservation",
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomElevatedButton(
                            onPressed: () {
                              // show dialog to comfim this action and cost
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Add 1 hour"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Are you sure you want to add more time to your reservation?",
                                        ),
                                        Text(
                                          "this will cost you 50 EGP",
                                          style: getSemiBoldStyle(
                                            fontSize: 16,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);

                                          if (walletModel.balance <
                                              timerCubit.costOfSpot) {
                                            showSnakeBar(
                                              msg: "Insufficient balance",
                                              snakeBarType: SnakeBarType.error,
                                            );
                                            return;
                                          }

                                          timerCubit.addCurrentTime(
                                            // 1 houre in secends
                                            durationInSeconds: 3600,
                                          );

                                          walletModel.removeBalance(
                                            timerCubit.costOfSpot,
                                          );
                                          WalletCubit.get(context)
                                              .addTranslation(
                                            TransactionModel(
                                              amount: double.parse(
                                                timerCubit.costOfSpot
                                                    .toString(),
                                              ),
                                              isAdded: false,
                                            ),
                                          );
                                          showSnakeBar(
                                            msg: "Added 1 hour successfully",
                                            snakeBarType: SnakeBarType.success,
                                          );
                                        },
                                        child: const Text("Confirm"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            text: "Add 1 hour",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // spot header
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
