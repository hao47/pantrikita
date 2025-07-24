import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry/presentation/widgets/card_summary_pantry.dart';

class PantryPage extends StatelessWidget {
  const PantryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
              child: Column(
                children: [
                  Center(child: Text('Pantry', style: tsBodyLargeSemibold(ColorValue.black))),

                  SizedBox(height: 20),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CardSummaryPantry(textTitle: 'Total', totalCount: 8, countColor: ColorValue.black),
                        CardSummaryPantry(textTitle: 'Fresh', totalCount: 3, countColor: ColorValue.green),
                        CardSummaryPantry(textTitle: 'Expiring', totalCount: 2, countColor: ColorValue.primary),
                        CardSummaryPantry(textTitle: 'Expired', totalCount: 4, countColor: ColorValue.red),
                      ]
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          )
      )
    );
  }
}
