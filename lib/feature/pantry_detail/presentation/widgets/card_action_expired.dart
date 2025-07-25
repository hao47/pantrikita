import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CardActionExpired extends StatelessWidget {
  CardActionExpired({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05, horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
            color: ColorValue.redStatusTransparant,
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
                child: Center(child: Icon(Icons.warning_amber_outlined, color: ColorValue.red, size: screenWidth * 0.08)),
              ),

              SizedBox(height: 20),

              Text(
                'What happened to this expired item?',
                style: tsBodySmallMedium(ColorValue.greenDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'Help us track food waste and environmental impact',
                style: tsLabelLargeRegular(ColorValue.grayDark),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: ColorValue.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/plant.svg', width: 24, height: 24),
                    SizedBox(width: screenWidth * 0.02),
                    Text('Made Into Compost', style: tsBodySmallMedium(ColorValue.whiteColor), textAlign: TextAlign.center),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: ColorValue.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorValue.red, width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.highlight_remove, color: ColorValue.red, size: 24),
                    SizedBox(width: screenWidth * 0.02),
                    Text('Thrown Away', style: tsBodySmallMedium(ColorValue.red), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ]
        )
    );
  }
}