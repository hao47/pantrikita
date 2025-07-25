import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CardTabComposting extends StatelessWidget {
  CardTabComposting({
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

              // * Icon and Title * //
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/plant.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      ColorValue.black,
                      BlendMode.srcIn,
                    )
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text('Composting Guide', style: tsBodySmallMedium(ColorValue.black)),
                ],
              ),

              SizedBox(height: 20),

              // * ListView * //
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: _containerComposting(
                        context: context,
                        index: index,
                        textGuide: 'Collect your food scraps and yard waste in a compost bin or pile',
                      )
                  );
                },
              ),

              SizedBox(height: 20),

              // * Environmental Impact * //
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: ColorValue.greenStatusTransparant,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/leaf.svg', width: 24, height: 24),
                        SizedBox(width: screenWidth * 0.02),
                        Text('Environmental Impact', style: tsBodySmallSemibold(ColorValue.greenDark)),
                      ],
                    ),

                    SizedBox(height: 10),

                    Text('Composting reduces waste and enriches soil, promoting a healthier environment.', style: tsLabelLargeMedium(ColorValue.greenDark)),
                  ],
                ),
              )
            ]
        )
    );
  }

  Widget _containerComposting({
    required BuildContext context,
    required int index,
    required String textGuide,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * 0.07,
                height: screenWidth * 0.07,
                decoration: BoxDecoration(
                  color: ColorValue.greenStatusTransparant,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${index + 1}', style: tsLabelLargeMedium(ColorValue.greenDark)),
                ),
              ),

              SizedBox(width: screenWidth * 0.03),

              Expanded(
                child: Text(textGuide, style: tsBodySmallRegular(ColorValue.black)),
              ),
            ]
        )
    );
  }
}