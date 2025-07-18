import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/constants_manager.dart';

import '../../../../core/utils/widgets/custom_scaffold_message.dart';
import '../cubit/favorite_cubit.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Card(
          elevation: 5,
          margin: EdgeInsets.only(bottom: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // image
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  ConstantsManager.tempeMa3adyGarage,
                  height: 120.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // address
                    Row(
                      children: [
                        Text(
                          "جراج المعادي",
                          style: getSemiBoldStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "EGP 50",
                          style: getBoldStyle(
                            fontSize: 16,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: ColorManager.primaryColor,
                          size: 18.sp,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "9134 Holly St, المعادي",
                          style: getRegularStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // rating and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 18),
                            SizedBox(width: 4),
                            Text(
                              "4.5",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Text(
                          " 15 /Hour",
                          style: getMediumStyle(
                            fontSize: 12,
                            color: ColorManager.grey2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.lightPink,
            ),
            child: IconButton(
              onPressed: () {
                FavoriteCubit.get(context).removeFavorite(id);
                showScaffoldMessage(context, message: "Removed From Favorites");
              },
              padding: EdgeInsets.zero,
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30.sp,
              ),
            ),
            // child: FavoriteButton(
            //   isFavorite: true,
            //   iconSize: 35.r,
            //   iconColor: Colors.red,
            //   iconDisabledColor: Colors.white,
            //   valueChanged: (value) {
            //     kprint('id tapped : $id  value : $value');
            //     FavoriteCubit.get(context).removeFavorite(id);
            //     showScaffoldMessage(context, message: "Removed From Favorites");
            //   },
            // ),
          ),
        ),
      ],
    );
  }
}
