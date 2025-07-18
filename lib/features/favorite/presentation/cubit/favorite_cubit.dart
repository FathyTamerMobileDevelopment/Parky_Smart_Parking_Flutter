import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/favorite_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  static FavoriteCubit get(BuildContext context) => BlocProvider.of(context);

  List<FavoriteModel> favorites = [];
  bool isFavoriteGarage = false;

  // add to favorite
  void addToFavorite(int id) {
    favorites.add(
      FavoriteModel(
        id: id,
      ),
    );
    isFavoriteGarage = true;

    emit(FavoriteAdded());
  }

  // remove from Favorite
  void removeFavorite(int id) {
    favorites.removeWhere((element) => element.id == id);
    isFavoriteGarage = false;
    emit(FavoriteRemoved());
  }
}
