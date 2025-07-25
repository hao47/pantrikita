import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_warning_pantry_detail.dart';

class CardItemPantryDetail extends StatelessWidget {
  CardItemPantryDetail({
    super.key,
    required this.icon,
    required this.textName,
    required this.textCategory,
    required this.textStatus,
    required this.textLocation,
    required this.textExpiryDate,
    required this.textWarning,
    required this.status,
  });

  final String icon;
  final String textName;
  final String textCategory;
  final String textStatus;
  final String textLocation;
  final String textExpiryDate;
  final String textWarning;
  final String status;

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
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorValue.gray, width: 0.5)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ** Detail Item Information ** ///
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      color: ColorValue.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(icon, style: tsBodyLargeRegular(ColorValue.black))
                    )
                ),

                SizedBox(width: screenWidth * 0.03),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(textName, style: tsBodyLargeMedium(ColorValue.black)),
                    const SizedBox(height: 5),
                    Text(textCategory, style: tsLabelLargeRegular(ColorValue.grayDark)),

                    const SizedBox(height: 10),

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
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ** Expiry Date and Location ** //
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.375,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, color: ColorValue.grayDark, size: screenWidth * 0.05),
                        SizedBox(width: screenWidth * 0.02),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Expiry Date', style: tsLabelLargeRegular(ColorValue.grayDark), overflow: TextOverflow.ellipsis),
                              SizedBox(height: 5),
                              Text(textExpiryDate, style: tsBodySmallMedium(ColorValue.black), overflow: TextOverflow.ellipsis),
                            ]
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    width: screenWidth * 0.375,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: ColorValue.grayDark, size: screenWidth * 0.05),
                        SizedBox(width: screenWidth * 0.02),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Location', style: tsLabelLargeRegular(ColorValue.grayDark), overflow: TextOverflow.ellipsis),
                              SizedBox(height: 5),
                              Text(textLocation, style: tsBodySmallMedium(ColorValue.black), overflow: TextOverflow.ellipsis),
                            ]
                        )
                      ],
                    ),
                  )
                ]
            ),

            const SizedBox(height: 20),

            // ** Warning Card ** //
            _cardWarning(status: status, textWarning: textWarning),
          ],
        )
    );
  }

  Widget _cardWarning({
    required String status,
    required String textWarning
  }) {
    switch (status) {
      case 'YELLOW_TRANSPARENT':
        return CardWarningPantryDetail(
          textWarning: textWarning,
          colorBorder: ColorValue.yellowDark,
          colorBackground: ColorValue.yellowStatusTransparant,
          colorText: ColorValue.yellowDark,
        );
      case 'RED_TRANSPARENT':
        return CardWarningPantryDetail(
          textWarning: textWarning,
          colorBorder: ColorValue.red,
          colorBackground: ColorValue.redStatusTransparant,
          colorText: ColorValue.redDark,
        );
      default:
        return Container();
    }
  }
}