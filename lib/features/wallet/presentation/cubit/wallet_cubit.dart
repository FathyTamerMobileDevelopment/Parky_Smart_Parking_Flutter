import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/translation_model.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());
  static WalletCubit get(context) => BlocProvider.of(context);
  List<TransactionModel> translationList = [];

  void updateWallet() => emit(WalletUpdated());

  void updateBalance() => emit(BalanceUpdated());

  void addTranslation(TransactionModel translationModel) {
    translationList.add(translationModel);
    emit(TransactionAdded());
  }
}
