import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry_detail/data/domain/entities/pantry_detail.dart';

class CardTabUseEverything extends StatelessWidget {
  CardTabUseEverything({
    super.key,
    required this.pantryDetail,
  });

  final PantryDetail? pantryDetail;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant, color: ColorValue.black, size: 24),
                  SizedBox(width: screenWidth * 0.02),
                  Text('Zero-Waste Recipes', style: tsBodySmallMedium(ColorValue.black)),
                ],
              ),

              SizedBox(height: 20),

              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: pantryDetail!.data.useEverything.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = pantryDetail!.data.useEverything[index];

                  return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: _containerUseEverything(
                        context: context,
                        textName: item.title,
                        textDescription: item.description,
                        textDifficulty: item.difficulty,
                        textCookTime: item.cookTime,
                        textIngredient: item.ingredient,
                        textInstruction: item.instruction,
                      )
                  );
                },
              ),
            ]
        )
    );
  }

  Widget _containerUseEverything({
    required BuildContext context,
    required String textName,
    required String textDescription,
    required String textDifficulty,
    required String textCookTime,
    required String textIngredient,
    required String textInstruction,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;

    Color difficultyColor() {
      switch (textDifficulty.toLowerCase()) {
        case 'easy':
          return ColorValue.green;
        case 'medium':
          return ColorValue.yellowStatus;
        case 'hard':
          return ColorValue.red;
        default:
          return ColorValue.grayDark;
      }
    }

    Color difficultyBackgroundColor() {
      switch (textDifficulty.toLowerCase()) {
        case 'easy':
          return ColorValue.greenStatusTransparant;
        case 'medium':
          return ColorValue.yellowStatusTransparant;
        case 'hard':
          return ColorValue.redStatusTransparant;
        default:
          return ColorValue.grayTransparent;
      }
    }

    Color difficultyTextColor() {
      switch (textDifficulty.toLowerCase()) {
        case 'easy':
          return ColorValue.greenStatusTransparant;
        case 'medium':
          return ColorValue.yellowDark;
        case 'hard':
          return ColorValue.redStatusTransparant;
        default:
          return ColorValue.grayTransparent;
      }
    }

    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.03),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: ColorValue.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: difficultyColor(), width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Name and Description * //
            Row(
              children: [
                Icon(Icons.circle, color: difficultyColor(), size: 20),
                SizedBox(width: screenWidth * 0.02),
                Text(textName, style: tsBodyMediumMedium(ColorValue.black)),
              ],
            ),
            SizedBox(height: 10),
            Text(textDescription, style: tsLabelLargeRegular(ColorValue.grayDark)),

            SizedBox(height: 10),

            // * Cook Time and Difficulty * //
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, color: ColorValue.grayDark, size: 16),
                  SizedBox(width: screenWidth * 0.01),
                  Text(textCookTime, style: tsLabelLargeRegular(ColorValue.grayDark)),

                  SizedBox(width: screenWidth * 0.02),

                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: difficultyBackgroundColor(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(textDifficulty, style: tsLabelLargeMedium(difficultyTextColor()),)
                  ),
                ]
            ),

            SizedBox(height: 10),

            // * Ingredients * //
            Text('Ingredients:', style: tsLabelLargeMedium(ColorValue.black)),
            SizedBox(height: 2),
            Text(textIngredient, style: tsLabelLargeRegular(ColorValue.grayDark)),

            SizedBox(height: 10),

            // * Instructions * //
            Text('Instructions:', style: tsLabelLargeMedium(ColorValue.black)),
            SizedBox(height: 2),
            Text(textInstruction, style: tsLabelLargeRegular(ColorValue.grayDark)),
          ],
        )
    );
  }
}