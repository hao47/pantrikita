import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/theme/color_value.dart';

import '../../data/dropdown_data/category_dropdown_data.dart';
import '../../data/dropdown_data/sort_dropdown_data.dart';
import '../../data/dropdown_data/status_dropdown_data.dart';
import '../bloc/pantry_bloc.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/dropdown_filter_pantry.dart';

class ComponentFilterPantry extends StatelessWidget {
  ComponentFilterPantry({
    super.key,
    required this.state,
    required this.searchController,
  });

  final PantryState state;
  TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: ColorValue.whiteColor,
          border: Border.all(color: ColorValue.gray, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
                hintName: 'Search Items...',
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                onSearch: (query) {
                  searchController.text = query;
                  context.read<PantryBloc>().add(GetFilterSearchEvent(filterSearch: query));
                },
                onClearSearch: () {
                  searchController.clear();
                  context.read<PantryBloc>().add(GetFilterSearchEvent(filterSearch: ''));
                },
                searchController: searchController
            ),

            SizedBox(height: 10),

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
        )
    );
  }
}