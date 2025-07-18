import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/core/utils/widgets/custom_scaffold_message.dart';
import 'package:parky/core/utils/widgets/custom_text.dart';
import 'package:parky/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../core/utils/constants_manager.dart';

class CustomFamilyCard extends StatelessWidget {
  const CustomFamilyCard({
    super.key,
    this.isInviteCard = false,
    required this.id,
  });
  final bool isInviteCard;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              ConstantsManager.tempProfileImage,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mostafa Mohamed',
                style: getBoldStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                'mostafa@gmail.com',
                style: getRegularStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          const Spacer(),
          if (!isInviteCard) ...{
            IconButton(
              onPressed: () {
                ProfileCubit.get(context).removeFamily(id);
                showScaffoldMessage(
                  context,
                  message: "Removed From Family Comunity",
                  type: ErrorType.error,
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
                size: 22.r,
              ),
            ),
          } else ...{
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white),
                ),
                child: CustomText(
                  text: 'Reject',
                  style: getBoldStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // const SizedBox(width: 10),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: CustomText(
                  text: 'Accept',
                  style: getBoldStyle(
                    fontSize: 10,
                    color: ColorManager.primaryColor,
                  ),
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}
