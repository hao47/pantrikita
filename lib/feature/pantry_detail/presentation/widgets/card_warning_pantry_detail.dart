import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CardWarningPantryDetail extends StatelessWidget {
  CardWarningPantryDetail({
    super.key,
    required this.textWarning,
    required this.colorBorder,
    required this.colorBackground,
    required this.colorText,
  });

  String textWarning;
  Color colorBorder;
  Color colorBackground;
  Color colorText;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.03, ),
        decoration: BoxDecoration(
            color: colorBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorBorder, width: 0.5)
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.warning_amber_outlined, color: colorText, size: 24),
              SizedBox(width: screenWidth * 0.02),
              Expanded(child: Text(textWarning, style: tsLabelLargeMedium(colorText)))
            ]
        )
    );
  }
}