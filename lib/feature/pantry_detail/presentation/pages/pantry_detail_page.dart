import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/bloc/pantry_detail_bloc.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_action_consumed.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_action_expired.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/card_item_pantry_detail.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/widgets/tab_bar_pantry_detail.dart';

class PantryDetailPage extends StatelessWidget {
  const PantryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorValue.black),
          onPressed: () => navigatorPop(context),
        ),
        title: Text(
          'Pantry Detail',
          style: tsTitleMediumBold(ColorValue.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardItemPantryDetail(
                    textName: 'Milk',
                    textCategory: 'Dairy',
                    textLocation: 'Shelf 1',
                    textStatus: '1d left',
                    textExpiryDate: '2023-12-31',
                    textWarning: 'pls consume this food before it expired',
                    icon: '🥛',
                    status: 'YELLOW_TRANSPARENT',
                  ),

                  SizedBox(height: 20),

                  CardActionConsumed(),

                  SizedBox(height: 20),

                  CardActionExpired(),

                  SizedBox(height: 20),

                  BlocBuilder<PantryDetailBloc, PantryDetailState>(builder: (context, state) {
                    return TabPantryDetail(onValueChanged: (v) {
                      context.read<PantryDetailBloc>().add(GetChangeTabIndexEvent(changeTabIndex: v));
                    });
                  }),

                  SizedBox(height: 20),
                ],
              )
            ),
          )
      ),
    );
  }
}
