import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry_detail/data/domain/entities/pantry_detail.dart';

class CardTabSuggestedRecipes extends StatelessWidget {
  CardTabSuggestedRecipes({
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
                  SvgPicture.asset('assets/svg/chef_hat.svg', width: 24, height: 24),
                  SizedBox(width: screenWidth * 0.02),
                  Text('Suggested Recipes', style: tsBodySmallMedium(ColorValue.black)),
                ],
              ),

              SizedBox(height: 20),

              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: pantryDetail!.data.recipe.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = pantryDetail!.data.recipe[index];

                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: _containerSuggestedRecipes(
                          context: context,
                          textName: item.title,
                          textDescription: item.description,
                          textDifficulty: item.difficulty,
                          textCookTime: item.cookTime,
                      )
                    ),
                  );
                },
              ),
            ]
        )
    );
  }

  Widget _containerSuggestedRecipes({
    required BuildContext context,
    required String textName,
    required String textDescription,
    required String textDifficulty,
    required String textCookTime,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;

    Color difficultyColor() {
      switch (textDifficulty.toLowerCase()) {
        case 'easy':
          return ColorValue.greenDark;
        case 'medium':
          return ColorValue.yellowDark;
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

    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.03),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: ColorValue.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(textName, style: tsBodyMediumMedium(ColorValue.black)),
                    SizedBox(height: 2),
                    Text(textDescription, style: tsLabelLargeRegular(ColorValue.grayDark)),

                    SizedBox(height: 15),
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
                            child: Text(textDifficulty, style: tsLabelLargeMedium(difficultyColor()),)
                        ),
                      ]
                    ),
                  ],
                ),
              ),

              /// * Button Cook * ///
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: ColorValue.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Cook', style: tsBodySmallMedium(Colors.white)),
              ),
            ]
        )
    );
  }
}