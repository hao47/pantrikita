import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/widgets/custom_loading.dart';
import 'package:pantrikita/feature/scan/presentation/bloc/scan_bloc.dart';

import '../../../../core/theme/color_value.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/widgets/button.dart';


class ScanCamera extends StatelessWidget {
  const ScanCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: ColorValue.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorValue.gray.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorValue.greenStatusTransparant,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(20),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 50,
              color: ColorValue.green,
            ),
          ),
          const SizedBox(height: 20),
          Text("AI Recognition", style: tsBodyLargeMedium(ColorValue.black)),
          const SizedBox(height: 20),
          Text(
            "Take a photo let AI identify your food item automatically",
            style: tsBodySmallMedium(ColorValue.gray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          BlocConsumer<ScanBloc, ScanState>(
            listener: (context, state) {
              if(state.identifyStatus == IdentifyStatus.loading){



              }else if(state.identifyStatus == IdentifyStatus.success){



                final Map<int, String> _items = {
                  1: 'Fruit',
                  2: 'Vegetable',
                  3: 'Meat',
                  4: 'Dairy',
                  5: 'Grains',
                  6: 'Seafood',
                };

                final selectedCategoryId = _items.entries
                    .firstWhere(
                      (entry) => entry.value.toLowerCase() == state.identify!.data.category.toLowerCase(),
                  orElse: () => const MapEntry(1, 'Fruit'),
                )
                    .key;

                print(selectedCategoryId);

                context.read<ScanBloc>().add(
                  GetTabIndexEvent(
                    change_tab: 3
                  ),
                );

                context.read<ScanBloc>().add(
                  GetScanSaveStateEvent(categoryId: selectedCategoryId,item_name: state.identify!.data.name, category: state.identify!.data.category, expiring_date: state.identify!.data.expiringDate, location: state.identify!.data.location)
                );

              }else if(state == IdentifyStatus.error){

                print("error");
              }
            },
            builder: (context, state) {

              print(state.identifyStatus);

              if(state.identifyStatus == IdentifyStatus.loading){

                return CustomLoading();

              }else if(state == IdentifyStatus.success){

              }else if(state == IdentifyStatus.error){

                print("error");
              }

              return MyButton(
                widget: Text(
                  "Take Photo",
                  style: tsBodySmallMedium(ColorValue.whiteColor),
                ),
                height: 55,
                onPressed: () {
                  context.read<ScanBloc>().add(
                    PhotoClasifier(),
                  );
                },
                colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
                width: 150,
              );
            },
          ),
        ],
      ),
    );
  }
}
