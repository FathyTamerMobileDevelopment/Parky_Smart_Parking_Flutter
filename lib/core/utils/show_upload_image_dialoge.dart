import 'package:flutter/material.dart';

import 'custom_alert_dialoge.dart';

void showUploadImageOrVideoDialoge(
    {required BuildContext context,
    required void Function() onCameraSelected,
    required void Function() onGallerySelected}) {
  showCustomAlertDialoge(
    context: context,
    title: "choose source ",
    firstButtonName: 'Gallery',
    secondButtonName: "Camera",
    firstButtonFunction: onGallerySelected,
    secondButtonFunction: onCameraSelected,
  );
}
