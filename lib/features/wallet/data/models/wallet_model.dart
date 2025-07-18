import 'package:flutter/material.dart';

class WalletModel {
  // singleton
  static WalletModel? _instance;
  static WalletModel get instance => _instance ??= WalletModel(
        formKey: GlobalKey<FormState>(),
        cardNumber: TextEditingController(),
        cardName: TextEditingController(),
        cvv: TextEditingController(),
        expiryDate: TextEditingController(),
        balance: 0,
      );

  GlobalKey<FormState> formKey;
  TextEditingController cardNumber;
  TextEditingController cardName;
  TextEditingController cvv;
  TextEditingController expiryDate;
  double balance;

  WalletModel({
    required this.formKey,
    required this.cardNumber,
    required this.cardName,
    required this.cvv,
    required this.expiryDate,
    required this.balance,
  });

  // add balance
  void addBalance(double amount) {
    balance += amount;
  }

  // remove balance
  void removeBalance(double amount) {
    balance -= amount;
  }
}
