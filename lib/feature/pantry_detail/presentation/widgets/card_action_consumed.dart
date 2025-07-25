import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CardActionConsumed extends StatelessWidget {
  CardActionConsumed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05, horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
            color: ColorValue.greenStatusTransparant,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorValue.gray, width: 0.5)
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.175,
                height: screenWidth * 0.175,
                decoration: BoxDecoration(
                  color: ColorValue.whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Icon(Icons.check_circle_outline, color: ColorValue.primary, size: screenWidth * 0.08)),
              ),

              SizedBox(height: 20),

              Text(
                'Did you consume this item?',
                style: tsBodySmallMedium(ColorValue.greenDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'Mark as consumed to track your food waste prevention impact',
                style: tsLabelLargeRegular(ColorValue.grayDark),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: ColorValue.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, color: ColorValue.whiteColor, size: 24),
                    SizedBox(width: screenWidth * 0.02),
                    Text('Mark as Consumed', style: tsBodySmallMedium(ColorValue.whiteColor), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ]
        )
    );
  }
}