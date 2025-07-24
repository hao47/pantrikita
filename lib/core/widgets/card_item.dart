import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CardItem extends StatelessWidget {
  CardItem({
    super.key,
    required this.textName,
    required this.textCategory,
    required this.textLocation,
    required this.textStatus,
    required this.icon,
    required this.status,
  });

  String textName;
  String textCategory;
  String textLocation;
  String textStatus;
  String icon;
  String status;

  Color statusColor() {
    switch (status) {
      case 'GREEN_TRANSPARENT':
        return ColorValue.green;
      case 'YELLOW_TRANSPARENT':
        return ColorValue.yellowDark;
      case 'RED_TRANSPARENT':
        return ColorValue.red;
      default:
        return ColorValue.grayDark;
    }
  }

  Color statusBackgroundColor() {
    switch (status) {
      case 'GREEN_TRANSPARENT':
        return ColorValue.greenStatusTransparant;
      case 'YELLOW_TRANSPARENT':
        return ColorValue.yellowStatusTransparant;
      case 'RED_TRANSPARENT':
        return ColorValue.redStatusTransparant;
      default:
        return ColorValue.grayDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: double.infinity,
        height: screenWidth * 0.2,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        decoration: BoxDecoration(
            color: ColorValue.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorValue.gray, width: 0.5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        color: ColorValue.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(icon, style: tsBodyLargeRegular(ColorValue.black))
                      )
                  ),

                  const SizedBox(width: 10),

                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(textName, style: tsBodySmallMedium(ColorValue.black)),

                        Row(
                            children: [
                              Text(textCategory, style: tsLabelLargeRegular(ColorValue.grayDark)),
                              const SizedBox(width: 4),
                              Text('•', style: tsLabelLargeRegular(ColorValue.grayDark)),
                              const SizedBox(width: 4),
                              Text(textLocation, style: tsLabelLargeRegular(ColorValue.grayDark)),
                            ]
                        )
                      ]
                  )
                ]

            ),

            Spacer(),

            Container(

                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBackgroundColor(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  textStatus,
                  style: tsLabelLargeMedium(statusColor()),
                )

            ),
          ],
        )
    );
  }
}