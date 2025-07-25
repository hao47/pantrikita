import 'package:flutter/material.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/widgets/card_item.dart';
import 'package:pantrikita/feature/pantry/presentation/bloc/pantry_bloc.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/pages/pantry_detail_page.dart';

class ComponentListviewPantry extends StatelessWidget {
  ComponentListviewPantry({
    super.key,
    required this.state,
  });

  final PantryState state;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: state.pantryResponse!.data.items.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = state.pantryResponse!.data.items[index];

        return InkWell(
          onTap: () {
            navigatorPush(context, PantryDetailPage(pantryId: item.id));
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            child: CardItem(
              textName: item.name,
              textCategory: item.category,
              textLocation: item.location,
              textStatus: item.expired.statusText,
              icon: item.icon ?? '❓',
              status: item.expired.statusColor,
            ),
          ),
        );
      },
    );
  }
}