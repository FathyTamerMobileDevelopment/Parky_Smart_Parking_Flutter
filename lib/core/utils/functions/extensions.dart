import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension FileExtension on File? {
  bool get isNotEmpty => this != null && this!.path.isNotEmpty;

  bool get isEmpty => !isNotEmpty;

  /// Check if the file size is less than or equal to 10 MB
  bool get validSize {
    try {
      return isNotEmpty &&
          // 10 is the maximum file size in MB
          this!.lengthSync() <= 10 * 1024 * 1024;
    } catch (e) {
      return false;
    }
  }
}

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Map<String, dynamic> get args =>
      ModalRoute.of(this)!.settings.arguments as Map<String, dynamic>;
}

extension ColorShadesExtension on Color {
  Color operator [](int? shadeValue) {
    if (shadeValue == null) {
      return this;
    }
    // final shades = ColorShadesFactory.getShades(this);
    // if (shades != null) {
    //   return shades[shadeValue];
    // }

    return this;
  }
}

extension StringExtension on String {
  DateTime toDateTime() => DateTime.parse(this);

  String format({String format = 'yyyy-MM-dd'}) {
    final date = DateTime.parse(this);
    return DateFormat(format).format(date);
  }
}
