import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/routes/page_name.dart';
import 'package:parky/core/utils/functions/kprint.dart';
import 'package:parky/core/utils/services/snack_bar_service.dart';
import 'package:parky/features/wallet/data/models/wallet_model.dart';
import 'package:parky/features/wallet/presentation/cubit/wallet_cubit.dart';

import '../widgets/add_balance_dialog.dart';
import '../widgets/transaction_item.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    WalletModel walletModel = WalletModel.instance;
    kprint('update screen');
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              // الكارد الرئيسي (المحفظة)
              Row(
                children: [
                  if (walletModel.cardName.text.isNotEmpty) ...{
                    CustomDardDatal(
                      onAddBalance: () {
                        setState(() {
                          showSnakeBar(
                              msg: ' Balance Updated',
                              snakeBarType: SnakeBarType.success);
                          WalletCubit.get(context).updateBalance();
                          Navigator.pop(context);
                        });
                      },
                    ),
                  },
                  const SizedBox(width: 12),
                  // زر "إضافة بطاقة"
                  Expanded(
                    flex: 1,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(16),
                      // dashPattern: const [6, 3],
                      color: Colors.grey,
                      strokeWidth: 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PageName.addCardScreen);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            width: 70.w,
                            height: 155.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Icon(Icons.add,
                                  color: Colors.green, size: 30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // العنوان "Transaction History"
              const Text(
                "Transaction History",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // قائمة العمليات
              if (WalletCubit.get(context).translationList.isEmpty) ...{
                const Center(
                  child: Text(
                    'No Transactions yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              } else ...{
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: WalletCubit.get(context).translationList.length,
                    itemBuilder: (context, index) {
                      return TransactionItem(
                        transactionModel:
                            WalletCubit.get(context).translationList[index],
                      );
                    },
                  ),
                ),
              },
            ],
          ),
        );
      },
    );
  }
}

class CustomDardDatal extends StatelessWidget {
  const CustomDardDatal({
    super.key,
    this.onAddBalance,
  });
  final void Function()? onAddBalance;

  @override
  Widget build(BuildContext context) {
    WalletModel walletModel = WalletModel.instance;
    return Expanded(
      flex: 4,
      child: Card(
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // البطاقة الخضراء
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    walletModel.cardName.text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  // balance
                  Text(
                    //just 5 digits after dot
                    "${walletModel.balance.toStringAsFixed(5)} EGP",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Number",
                              style: TextStyle(color: Colors.white)),
                          Text(
                            walletModel.cardNumber.text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Exp",
                              style: TextStyle(color: Colors.white)),
                          Text(
                            walletModel.expiryDate.text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // زر الاستقبال
              ElevatedButton.icon(
                onPressed: () {
                  //show bottom sheet to add balance
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddBalanceDialog(
                        onAddBalance: onAddBalance,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.download, color: Colors.green),
                label: const Text("Receive"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
