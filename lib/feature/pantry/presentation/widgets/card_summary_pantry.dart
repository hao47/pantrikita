import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CardSummaryPantry extends StatelessWidget {
  CardSummaryPantry({
    super.key,
    required this.textTitle,
    required this.totalCount,
    required this.countColor,
  });

  String textTitle;
  int totalCount;
  Color countColor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: screenWidth * 0.21,
        height: screenWidth * 0.17,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorValue.gray, width: 0.5)
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(totalCount.toString(), style: tsBodyLargeMedium(countColor)),
              Text(textTitle, style: tsBodySmallRegular(ColorValue.grayDark))
            ]
        )
    );
  }
}