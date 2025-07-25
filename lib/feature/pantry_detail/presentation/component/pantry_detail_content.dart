import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry_detail/data/domain/entities/pantry_detail.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/bloc/pantry_detail_bloc.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_action_consumed.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_action_expired.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_item_pantry_detail.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_tab_composting.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_tab_suggested_recipes.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_tab_use_everything.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/tab_pantry_detail.dart';

class PantryDetailContent extends StatelessWidget {
  PantryDetailContent({super.key, required this.state});

  final PantryDetailState state;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
              child: Column(
                children: [
                  CardItemPantryDetail(
                    textName: state.pantryDetailResponse!.data.name,
                    textCategory: state.pantryDetailResponse!.data.category,
                    textLocation: state.pantryDetailResponse!.data.location,
                    textStatus: state.pantryDetailResponse!.data.headerStatus.statusText,
                    textExpiryDate: state.pantryDetailResponse!.data.expiringDate,
                    textWarning: state.pantryDetailResponse!.data.bodyStatus.statusText,
                    icon: state.pantryDetailResponse!.data.icon,
                    status: state.pantryDetailResponse!.data.headerStatus.statusColor,
                  ),

                  SizedBox(height: 20),

                  // * Card Action * //
                  _cardAction(
                      state.pantryDetailResponse!.data.headerStatus.statusText.toLowerCase(),
                      state.pantryDetailResponse!.data.id.toString()
                  ),

                  SizedBox(height: 20),

                  // * Tab Pantry Detail * //
                  BlocBuilder<PantryDetailBloc, PantryDetailState>(builder: (context, state) {
                    return TabPantryDetail(onValueChanged: (v) {
                      context.read<PantryDetailBloc>().add(GetChangeTabIndexEvent(changeTabIndex: v));
                    });
                  }),

                  SizedBox(height: 20),

                  // * Card Tab Content * //
                  _cardTab(state.changeTabIndex, state.pantryDetailResponse),

                  SizedBox(height: 20),

                  // * Delete Button * //
                  InkWell(
                    onTap: () {
                      context.read<PantryDetailBloc>().add(DeletePantryDetailEvent(pantryId: state.pantryDetailResponse!.data.id.toString()));
                      SnackBar(
                        content: Text('Item deleted successfully!'),
                        backgroundColor: ColorValue.red,
                      );
                      navigatorPop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: ColorValue.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline, color: ColorValue.whiteColor, size: 24),
                          SizedBox(width: screenWidth * 0.02),
                          Text('Delete Item', style: tsBodySmallMedium(ColorValue.whiteColor), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }

  Widget _cardTab(int index, PantryDetail? pantryDetail) {
    switch (index) {
      case 1:
        return CardTabSuggestedRecipes(pantryDetail: pantryDetail);
      case 2:
        return CardTabUseEverything(pantryDetail: pantryDetail);
      case 3:
        return CardTabComposting(pantryDetail: pantryDetail);
      default:
        return Container();
    }
  }

  Widget _cardAction(String status, String pantryId) {
    if (status != 'expired') {
      return CardActionConsumed(pantryId: pantryId,);
    } else if (status == 'expired') {
      return CardActionExpired(pantryId: pantryId,);
    } else {
      return Container();
    }
  }
}