import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:parky/features/favorite/presentation/widgets/favorite_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var favoriteList = FavoriteCubit.get(context).favorites;

        if (favoriteList.isEmpty) {
          return Center(
            child: Text(
              TextManager.yourFavIsEmpty.tr(),
              style: getBoldStyle(
                fontSize: 18,
                color: ColorManager.primaryColor,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: favoriteList.length,
            itemBuilder: (context, index) {
              return FavoriteCard(
                id: favoriteList[index].id,
              );
            },
          ),
        );
      },
    );
  }
}
