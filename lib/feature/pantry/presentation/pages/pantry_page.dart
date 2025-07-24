import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry/data/dropdown_data/category_dropdown_data.dart';
import 'package:pantrikita/feature/pantry/data/dropdown_data/sort_dropdown_data.dart';
import 'package:pantrikita/feature/pantry/data/dropdown_data/status_dropdown_data.dart';
import 'package:pantrikita/feature/pantry/presentation/bloc/pantry_bloc.dart';
import 'package:pantrikita/feature/pantry/presentation/widgets/card_summary_pantry.dart';
import 'package:pantrikita/feature/pantry/presentation/widgets/dropdown_filter_pantry.dart';

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

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<PantryBloc, PantryState>(builder: (context, state) {
                          return DropdownFilterPantry(
                            items: categoryDropdownData,
                            selectedValue: state.filterCategory,
                            onChanged: (value) {
                              context.read<PantryBloc>().add(GetFilterCategoryEvent(filterCategory: value));
                            },
                          );
                        }),

                        BlocBuilder<PantryBloc, PantryState>(builder: (context, state) {
                          return DropdownFilterPantry(
                            items: statusDropdownData,
                            selectedValue: state.filterStatus,
                            onChanged: (value) {
                              context.read<PantryBloc>().add(GetFilterStatusEvent(filterStatus: value));
                            },
                          );
                        }),

                        BlocBuilder<PantryBloc, PantryState>(builder: (context, state) {
                          return DropdownFilterPantry(
                            items: sortDropdownData,
                            selectedValue: state.filterSort,
                            onChanged: (value) {
                              context.read<PantryBloc>().add(GetFilterSortEvent(filterSort: value));
                            },
                          );
                        }),
                      ]
                  )
                ],
              ),
            ),
          )
      )
    );
  }
}
