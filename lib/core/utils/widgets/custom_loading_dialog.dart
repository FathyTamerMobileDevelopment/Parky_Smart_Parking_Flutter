import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:parky/core/utils/widgets/custom_alert_dialog.dart';
import 'package:parky/config/themes/text_manager.dart';

void customLoadingDialog({
  required BuildContext context,
  String? text,
}) {
  showCustomAlertDialog(
    context: context,
    title: text ?? TextManager.loading.tr(),
    content: const Center(child: CircularProgressIndicator()),
  );
}
