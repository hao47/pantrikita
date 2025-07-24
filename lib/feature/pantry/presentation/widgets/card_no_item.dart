import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CardNoItem extends StatelessWidget {
  CardNoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.1, horizontal: screenWidth * 0.1),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorValue.gray, width: 0.5)
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'assets/svg/box.svg',
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  colorFilter: ColorFilter.mode(
                    ColorValue.grayDark,
                    BlendMode.srcIn,
                  )
              ),
              SizedBox(height: 15),
              Text(
                'No Items Found',
                style: tsBodyLargeMedium(ColorValue.grayDark),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'Try Adjusting Your Filters or Adding New Items',
                style: tsLabelLargeRegular(ColorValue.grayDark),
                textAlign: TextAlign.center,
              ),
            ]
        )
    );
  }
}