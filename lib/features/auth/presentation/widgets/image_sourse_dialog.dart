import 'package:flutter/material.dart';
import 'package:parky/core/utils/functions/kprint.dart';

import '../../../../config/themes/color_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/functions/image_picker_service.dart';

void showImageSourceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Choose An Option",
          style: getSemiBoldStyle(
            color: ColorManager.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(
                "Take A Picture",
                style: getMediumStyle(
                  color: ColorManager.primaryColor,
                ),
              ),
              onTap: () async {
                // ProfileCubit.get(context).pickImageFromCamera().then(
                //   (value) {
                //     // ignore: use_build_context_synchronously
                //     Navigator.pop(context);
                //   },
                // );
                ImagePickerService.pickFromCamera().then(
                  (value) {
                    kprint("Image: ${value!.name}");
                    Navigator.pop(context);
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: Text(
                "Choose From Gallery",
                style: getMediumStyle(
                  color: ColorManager.primaryColor,
                ),
              ),
              onTap: () async {
                // ProfileCubit.get(context).pickImageFromGallery().then(
                //   (value) {
                //     // ignore: use_build_context_synchronously
                //     Navigator.pop(context);
                //   },
                // );
              },
            ),
          ],
        ),
      );
    },
  );
}
