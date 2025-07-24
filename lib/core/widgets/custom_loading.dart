import 'package:flutter/material.dart';

import '../theme/color_value.dart';


class CustomLoading extends StatelessWidget {
  const CustomLoading ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorValue.primary,
      ),
    );
  }
}
