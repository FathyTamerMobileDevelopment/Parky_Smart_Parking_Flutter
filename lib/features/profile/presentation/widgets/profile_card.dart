import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parky/config/themes/color_manager.dart';
import 'package:parky/config/themes/text_style.dart';
import 'package:parky/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/show_upload_image_dialoge.dart';
import '../../../../core/utils/widgets/circular_image.dart';
import '../../../auth/data/models/register_model.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key, this.enableEdit = false});
  final bool enableEdit;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    RegisterModel registerModel = RegisterModel();
    final profileCubit = ProfileCubit.get(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is GetProfileLoading,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: ColorManager.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircularImage(
                  radius: 30.r,
                  networkImage: registerModel.avatar,
                  fileImage: RegisterModel().image,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${registerModel.firstNameController.text} ${registerModel.lastNameController.text}",
                      style: getBoldStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      registerModel.emailController.text,
                      style: getRegularStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
                if (widget.enableEdit) ...{
                  IconButton(
                    onPressed: () {
                      showUploadImageOrVideoDialoge(
                        context: context,
                        onCameraSelected: () async {
                          Navigator.pop(context);

                          RegisterModel().image = await profileCubit
                              .updateProfileImage(ImageSource.camera);
                          setState(() {});
                        },
                        onGallerySelected: () async {
                          Navigator.pop(context);

                          RegisterModel().image = await profileCubit
                              .updateProfileImage(ImageSource.gallery);

                          setState(() {});
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )
                },
              ],
            ),
          ),
        );
      },
    );
  }
}
