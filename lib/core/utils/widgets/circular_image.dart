import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/color_manager.dart';
import '../functions/kprint.dart';

class CircularImage extends StatelessWidget {
  final double radius;
  final String? networkImage;
  final String? assetsImage;
  final File? fileImage;
  const CircularImage({
    super.key,
    required this.radius,
    this.networkImage,
    this.assetsImage,
    this.fileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (radius * 2).r,
      height: (radius * 2).r,
      decoration: BoxDecoration(
        color: ColorManager.grey3,
        border: Border.all(color: ColorManager.grey),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: networkImage != null
            ? CachedNetworkImage(
                imageUrl: networkImage!.trim(),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Image.network(
                    "https://img.freepik.com/premium-vector/businessman-avatar_24908-26533.jpg?w=996",
                    fit: BoxFit.cover,
                  );
                },
                errorListener: (exception) {
                  kprint("Error: $exception");
                },
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
              )
            : fileImage != null
                ? Image.file(
                    File(fileImage!.path),
                    fit: BoxFit.cover,
                  )
                : assetsImage != null
                    ? Image.asset(
                        assetsImage!,
                        fit: BoxFit.cover,
                      )
                    : null,
      ),
    );
  }
}
