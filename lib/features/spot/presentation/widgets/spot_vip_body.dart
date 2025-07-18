import 'package:flutter/material.dart';

import 'custom_entry.dart';
import 'custom_vip_image.dart';

class SpotVipBody extends StatefulWidget {
  const SpotVipBody({super.key, required this.onSelected});
  final void Function(bool isSelected) onSelected;

  @override
  State<SpotVipBody> createState() => _SpotVipBodyState();
}

class _SpotVipBodyState extends State<SpotVipBody> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           const CustomEntry(),
          CustomVipImage(
            isShape2: true,
            isSelected: currentIndex == 1,
            onTap: () {
              setState(() {
                currentIndex = 1;
                widget.onSelected(true);
              });
            },
          ),
          const CustomEntry(isEntry: false),
          CustomVipImage(
            isShape2: false,
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
    );
  }
}
