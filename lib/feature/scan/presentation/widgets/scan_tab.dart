import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/text_style.dart';

class ScanTab extends StatelessWidget {

  final void Function(int v) onValueChanged;

  ScanTab({super.key,required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      initialValue: 1,
      children: {
        1: Row(
          spacing: 7,
          children: [
            SvgPicture.asset('assets/svg/barcode.svg', width: 25),

            Text('Barcode', style: tsLabelLargeMedium(Colors.black)),
          ],
        ),
        2: Row(
          spacing: 7,
          children: [
            SvgPicture.asset('assets/svg/camera.svg', width: 25),

            Text('Camera', style: tsLabelLargeMedium(Colors.black)),
          ],
        ),
        3: Row(
          spacing: 7,
          children: [
            SvgPicture.asset('assets/svg/black_box.svg', width: 25),

            Text('Manual', style: tsLabelLargeMedium(Colors.black)),
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
