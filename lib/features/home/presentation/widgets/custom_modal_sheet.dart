import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/routes/page_name.dart';
import 'package:parky/core/utils/functions/kprint.dart';
import 'package:parky/core/utils/services/snack_bar_service.dart';
import 'package:parky/core/utils/widgets/custom_elevated_button.dart';

import '../../../../config/themes/color_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../favorite/presentation/cubit/favorite_cubit.dart';

class CustomModalSheet extends StatelessWidget {
  const CustomModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
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
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 18),
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
                  // child: IconButton(
                  //   onPressed: () {
                  //     FavoriteCubit.get(context).removeFavorite(id);
                  //     showScaffoldMessage(context,
                  //         message: "Removed From Favorites");
                  //   },
                  //   padding: EdgeInsets.zero,
                  //   style: IconButton.styleFrom(
                  //     padding: EdgeInsets.zero,
                  //     minimumSize: Size.zero,
                  //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //   ),
                  //   icon: Icon(
                  //     Icons.favorite,
                  //     color: Colors.red,
                  //     size: 30.sp,
                  //   ),
                  // ),
                  child: FavoriteButton(
                    isFavorite: FavoriteCubit.get(context).isFavoriteGarage,
                    iconSize: 35.r,
                    iconColor: Colors.red,
                    iconDisabledColor: Colors.white,
                    valueChanged: (value) {
                      kprint('value is : $value');
                      if (value == true) {
                        FavoriteCubit.get(context).addToFavorite(10);
                        showSnakeBar(
                          msg: 'Added To Favorite',
                          snakeBarType: SnakeBarType.success,
                        );
                      } else {
                        FavoriteCubit.get(context).removeFavorite(10);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, PageName.spotScreen);
            },
            text: "Book Now",
            borderRadius: 35.r,
          )
        ],
      ),
    );
  }
}
