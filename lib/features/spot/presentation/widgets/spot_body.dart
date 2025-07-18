import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'csutom_parking_image.dart';
import 'custom_entry.dart';

class SpotBody extends StatefulWidget {
  const SpotBody({super.key, required this.onSelected});
  final void Function(bool isSelected) onSelected;

  @override
  State<SpotBody> createState() => _SpotBodyState();
}

class _SpotBodyState extends State<SpotBody> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomEntry(),
        Row(
          children: [
            CsutomParkingImage(
              isSelected: currentIndex == 1,
              onTap: () {
                setState(() {
                  currentIndex = 1;
                  widget.onSelected(true);
                });
              },
            ),
            SizedBox(width: 20.w),
            CsutomParkingImage(
              isParing1: true,
              isSelected: currentIndex == 2,
              onTap: () {
                setState(() {
                  currentIndex = 2;
                  widget.onSelected(true);
                });
              },
            ),
          ],
        ),
        const CustomEntry(isEntry: false),
      ],
    );
  }
}
