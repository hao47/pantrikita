import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/color_value.dart';
import '../../../../core/theme/text_style.dart';
import '../bloc/scan_bloc.dart';


class DropdownCategory extends StatelessWidget {
  DropdownCategory({super.key});

  final Map<int, String> _items = {
    1: 'Fruit',
    2: 'Vegetable',
    3: 'Meat',
    4: 'Dairy',
    5: 'Grains',
    6: 'Seafood',
  };


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      builder: (context, state) {

        final data = state.category_id;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: ColorValue.gray),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              dropdownColor: ColorValue.whiteColor,
              value: data,
              onChanged: (int? newValue) {},
              items: _items.entries.map<DropdownMenuItem<int>>((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(
                    entry.value,
                    style: tsLabelLargeMedium(ColorValue.black),
                  ),
                );
              }).toList(),
              iconEnabledColor: ColorValue.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        );
      },
    );
  }
}
