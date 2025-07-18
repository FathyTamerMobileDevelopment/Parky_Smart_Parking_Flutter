import 'package:flutter/material.dart';

import '../widgets/custom_map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: CustomMap()),
      ],
    );
  }
}
