import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry/presentation/bloc/pantry_bloc.dart';
import 'package:pantrikita/feature/pantry/presentation/component/component_filter_pantry.dart';
import 'package:pantrikita/feature/pantry/presentation/component/component_listview_pantry.dart';
import 'package:pantrikita/feature/pantry/presentation/widgets/card_no_item.dart';
import 'package:pantrikita/feature/pantry/presentation/widgets/card_summary_pantry.dart';

class PantryContent extends StatelessWidget {
  PantryContent({super.key, required this.state}) {
    ctrSearch.text = state.filterSearch;
  }

  final PantryState state;
  final TextEditingController ctrSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (ctrSearch.text != state.filterSearch) {
      ctrSearch.text = state.filterSearch;
    }
    
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: RefreshIndicator(
          backgroundColor: ColorValue.whiteColor,
          color: ColorValue.primary,
          onRefresh: () async {
            context.read<PantryBloc>().add(GetPantryEvent());
          },
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: screenWidth,
                constraints: BoxConstraints(
                  minHeight: screenHeight - 20,
                ),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
                child: Column(
                  children: [
                    Center(child: Text('Pantry', style: tsBodyLargeSemibold(ColorValue.black))),

                    SizedBox(height: 20),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CardSummaryPantry(textTitle: 'Total', totalCount: state.pantryResponse!.data.totalItems.total, countColor: ColorValue.black),
                          CardSummaryPantry(textTitle: 'Fresh', totalCount: state.pantryResponse!.data.totalItems.fresh, countColor: ColorValue.green),
                          CardSummaryPantry(textTitle: 'Expiring', totalCount: state.pantryResponse!.data.totalItems.expiring, countColor: ColorValue.primary),
                          CardSummaryPantry(textTitle: 'Expired', totalCount: state.pantryResponse!.data.totalItems.expired, countColor: ColorValue.red),
                        ]
                    ),

                    SizedBox(height: 20),

                    ComponentFilterPantry(state: state, searchController: ctrSearch),

                    SizedBox(height: 20),

                    state.pantryResponse?.data.items.isNotEmpty ?? true
                      ? ComponentListviewPantry(state: state)
                      : CardNoItem(),

                    SizedBox(height: 20),
                  ],
                ),
              )
          ),
        )
    );
  }

}