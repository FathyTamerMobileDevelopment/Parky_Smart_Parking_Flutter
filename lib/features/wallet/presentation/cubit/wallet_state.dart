part of 'wallet_cubit.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletUpdated extends WalletState {}

class BalanceUpdated extends WalletState {}

class TransactionAdded extends WalletState {}
