import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/text_style.dart';

class TabPantryDetail extends StatelessWidget {
  TabPantryDetail({super.key,required this.onValueChanged});

  final void Function(int v) onValueChanged;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return CustomSlidingSegmentedControl<int>(
      initialValue: 1,
      children: {
        1: Row(
          spacing: 7,
          children: [
            Expanded(
                child: Center(child: Text('Recipes', style: tsLabelLargeMedium(Colors.black)))
            ),
          ],
        ),
        2: Row(
          spacing: 7,
          children: [
            Expanded(
                child: Center(child: Text('Use Everything', style: tsLabelLargeMedium(Colors.black)))
            ),
          ],
        ),
        3: Row(
          spacing: 7,
          children: [
            Expanded(
                child: Center(child: Text('Composting', style: tsLabelLargeMedium(Colors.black)))
            ),
          ],
        ),
      },
      fromMax: true,
      isStretch: true,

      decoration: BoxDecoration(
        color: CupertinoColors.lightBackgroundGray,
        borderRadius: BorderRadius.circular(15),
      ),

      thumbDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),

      ),
      innerPadding: EdgeInsets.all(10),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: onValueChanged,
    );
  }
}
