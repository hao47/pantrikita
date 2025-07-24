import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';


class WidgetLogoutLoading extends StatelessWidget {
  const WidgetLogoutLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: ColorValue.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Logging out...',
              style: tsBodyMediumMedium(ColorValue.gray),
            ),
            const SizedBox(height: 8),
            Text(
              'Please wait',
              style: tsBodySmallRegular(ColorValue.gray),
            ),
          ],
        ),
      ),
    );
  }
}

