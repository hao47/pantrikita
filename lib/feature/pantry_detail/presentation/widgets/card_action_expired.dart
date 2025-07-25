import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/bloc/pantry_detail_bloc.dart';

class CardActionExpired extends StatelessWidget {
  CardActionExpired({
    super.key,
    required this.pantryId,
  });

  final String pantryId;

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

              InkWell(
                onTap: () {
                  context.read<PantryDetailBloc>().add(PutPantryDetailEvent(pantryId: pantryId, status: 'compost'));
                  SnackBar(
                    content: Text('Item marked as composted successfully!'),
                    backgroundColor: ColorValue.green,
                  );
                  navigatorPop(context);
                },
                child: Container(
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
              ),

              SizedBox(height: 10),

              InkWell(
                onTap: () {
                  context.read<PantryDetailBloc>().add(PutPantryDetailEvent(pantryId: pantryId, status: 'thrown'));
                  SnackBar(
                    content: Text('Item marked as thrown away successfully!'),
                    backgroundColor: ColorValue.red,
                  );
                  navigatorPop(context);
                },
                child: Container(
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
              ),
            ]
        )
    );
  }
}