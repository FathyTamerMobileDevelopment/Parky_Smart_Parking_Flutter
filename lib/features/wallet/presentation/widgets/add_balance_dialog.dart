import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';
import 'package:parky/core/utils/widgets/custom_text_form_field.dart';
import 'package:parky/features/wallet/data/models/translation_model.dart';
import 'package:parky/features/wallet/presentation/cubit/wallet_cubit.dart';

import '../../data/models/wallet_model.dart';

class AddBalanceDialog extends StatefulWidget {
  const AddBalanceDialog({super.key, this.onAddBalance});
  final void Function()? onAddBalance;

  @override
  State<AddBalanceDialog> createState() => _AddBalanceDialogState();
}

class _AddBalanceDialogState extends State<AddBalanceDialog> {
  TextEditingController balanceController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WalletModel walletModel = WalletModel.instance;

    return IntrinsicHeight(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                // width: 0.5.sw,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    controller: balanceController,
                    textHint: 'Add Balance',
                    hintColor: Colors.black38,
                    colorBorder: Colors.black,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        backgroundColor: Colors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Cancel',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          walletModel
                              .addBalance(double.parse(balanceController.text));
                          WalletCubit.get(context).addTranslation(
                            TransactionModel(
                              amount: double.parse(
                                balanceController.text,
                              ),
                              isAdded: true,
                            ),
                          );
                          widget.onAddBalance!();
                        },
                        text: 'Add',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
