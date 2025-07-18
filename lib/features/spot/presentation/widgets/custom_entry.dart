import 'package:flutter/material.dart';

import '../../../../config/themes/text_style.dart';

class CustomEntry extends StatelessWidget {
  const CustomEntry({super.key, this.isEntry = true});
  final bool isEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: Text(
        isEntry ? 'ENTRY' : 'EXIT',
        style: getMediumStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }
}
