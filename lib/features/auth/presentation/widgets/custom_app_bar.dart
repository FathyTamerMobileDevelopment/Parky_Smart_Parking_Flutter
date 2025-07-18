import 'package:flutter/material.dart';

import '../../../../config/themes/text_style.dart';

PreferredSizeWidget customAppBar({
  String? title,
  Color? arrowColor,
  void Function()? onBack,
}) =>
    AppBar(
      title: Text(
        title ?? '',
        style: getRegularStyle(fontSize: 18),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: arrowColor ?? Colors.black,
              width: 1,
            ),
          ),
          child: const Icon(Icons.arrow_back_ios),
        ),
        onPressed: onBack,
      ),
    );
