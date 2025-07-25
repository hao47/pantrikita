import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CardTabSuggestedRecipes extends StatelessWidget {
  CardTabSuggestedRecipes({
    super.key,
  });


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
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  return InkWell(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: _containerSuggestedRecipes(
                          context: context,
                          textName: 'Recipe Name $index',
                          textDescription: 'This is a description of the recipe. It is very delicious and easy to make.',
                          textDifficulty: (index % 3 == 0) ? 'Easy' : (index % 3 == 1) ? 'Medium' : 'Hard',
                          textCookTime: (index % 3 == 0) ? '30 mins' : (index % 3 == 1) ? '45 mins' : '1 hour',
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
          return ColorValue.green;
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