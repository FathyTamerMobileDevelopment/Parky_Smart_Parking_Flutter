import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';
import 'package:parky/core/utils/widgets/custom_scaffold_message.dart';
import 'package:parky/core/utils/widgets/custom_text_form_field.dart';
import 'package:parky/features/wallet/presentation/cubit/wallet_cubit.dart';

import '../../data/models/wallet_model.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletModel walletModel = WalletModel.instance;
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Form(
        key: walletModel.formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 0.17.sh,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorManager.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Add a new card",
                    style: getBoldStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    // overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 28.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Holder Name",
                            style: TextStyle(
                              color: ColorManager.black,
                              fontSize: 16,
                            ),
                          ),
                          CustomTextFormField(
                            controller: walletModel.cardName,
                            textHint: "Card Name",
                            fillColor: Colors.white,
                            colorBorder: ColorManager.primaryColor,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Card Number",
                            style: TextStyle(
                              color: ColorManager.black,
                              fontSize: 16,
                            ),
                          ),
                          CustomTextFormField(
                            controller: walletModel.cardNumber,
                            textHint: "Card Number",
                            fillColor: Colors.white,
                            colorBorder: ColorManager.primaryColor,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "CVV",
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 16,
                                  ),
                                ),
                                CustomTextFormField(
                                  controller: walletModel.cvv,
                                  fillColor: Colors.white,
                                  colorBorder: ColorManager.primaryColor,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Expire Date",
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 16,
                                  ),
                                ),
                                CustomTextFormField(
                                  controller: walletModel.expiryDate,
                                  fillColor: Colors.white,
                                  colorBorder: ColorManager.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      CustomElevatedButton(
                        onPressed: () {
                          if (!walletModel.formKey.currentState!.validate())
                            return;
                          WalletCubit.get(context).updateWallet();
                          showScaffoldMessage(
                            context,
                            message: "Card Added Successfully",
                          );
                          Navigator.pop(context);
                        },
                        text: "Add Card",
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
