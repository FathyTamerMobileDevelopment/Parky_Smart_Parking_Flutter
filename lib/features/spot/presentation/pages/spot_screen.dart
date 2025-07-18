import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/routes/page_name.dart';
import 'package:parky/core/utils/functions/kprint.dart';
import 'package:parky/core/utils/services/snack_bar_service.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';
import 'package:parky/core/utils/widgets/custom_scaffold_message.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';
import 'package:parky/features/wallet/data/models/wallet_model.dart';

import '../../../../config/themes/color_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../wallet/data/models/translation_model.dart';
import '../../../wallet/presentation/cubit/wallet_cubit.dart';
import '../cubit/timer_cubit/timer_cubit.dart';
import '../widgets/spot_body.dart';
import '../widgets/spot_header.dart';
import '../widgets/spot_vip_body.dart';

class SpotScreen extends StatefulWidget {
  const SpotScreen({super.key});

  @override
  State<SpotScreen> createState() => _SpotScreenState();
}

class _SpotScreenState extends State<SpotScreen> {
  bool isSelected = false;
  bool isVip = false;
  @override
  Widget build(BuildContext context) {
    WalletModel walletModel = WalletModel.instance;
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            height: 0.17.sh,
            child: Row(
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
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Selelct Spot",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 28.h),
                    // spot header
                    SpotHeader(
                      onChanged: (value) {
                        kprint(value);
                        if (value == 'VIP') {
                          setState(() {
                            isVip = true;
                          });
                        } else if (value == 'Standard') {
                          setState(() {
                            isVip = false;
                          });
                        }
                      },
                    ),

                    if (isVip) ...{
                      SpotVipBody(
                        onSelected: (isSelected) {
                          setState(() {
                            this.isSelected = isSelected;
                          });
                        },
                      ),
                    } else ...{
                      // spot body
                      SpotBody(
                        onSelected: (isSelected) {
                          setState(() {
                            this.isSelected = isSelected;
                          });
                        },
                      ),
                    },

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 56.h,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: isVip ? "220 EGP" : "50 EGP",
                      style: getBoldStyle(
                        color: ColorManager.primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    CustomText(
                      text: "/hour",
                      style: getMediumStyle(
                        color: ColorManager.grey3,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      if (!isSelected) {
                        showScaffoldMessage(
                          context,
                          message: "please select spot",
                          type: ErrorType.error,
                        );
                      } else {
                        // dialgog to confirm the payment
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Confirm Payment"),
                            content: const Text(
                                "Are you sure you want to make this payment?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                              // confirm
                              TextButton(
                                onPressed: () {
                                  var timerCubit = TimerCubit.get(context);
                                  if (!timerCubit.isTimerStart) {
                                    // check balance
                                    if (isVip) {
                                      if (walletModel.balance < 220) {
                                        Navigator.pop(context);
                                        showSnakeBar(
                                          msg: "Insufficient balance",
                                          snakeBarType: SnakeBarType.error,
                                        );
                                        return;
                                      }
                                    } else {
                                      if (walletModel.balance < 50) {
                                        Navigator.pop(context);
                                        showSnakeBar(
                                          msg: "Insufficient balance",
                                          snakeBarType: SnakeBarType.error,
                                        );
                                        return;
                                      }
                                    }
                                    timerCubit.costOfSpot = isVip ? 220 : 50;
                                    walletModel.removeBalance(
                                      isVip ? 220 : 50,
                                    );
                                    WalletCubit.get(context).addTranslation(
                                      TransactionModel(
                                        amount: double.parse(
                                          isVip ? "220" : "50",
                                        ),
                                        isAdded: false,
                                      ),
                                    );
                                    showSnakeBar(
                                      msg: "Booked successfully",
                                      snakeBarType: SnakeBarType.success,
                                    );
                                  }
                                  Navigator.pushNamed(
                                    context,
                                    PageName.timerscreen,
                                  );
                                },
                                child: const Text("Confirm"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    text: "Continue",
                    borderRadius: 35,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 20.h, color: Colors.white),
        ],
      ),
    );
  }
}
