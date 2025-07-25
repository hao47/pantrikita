import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/feature/scan/presentation/widgets/dropdown_category.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/theme/color_value.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/util/validator/validator.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/custom_textformfield.dart';
import '../bloc/scan_bloc.dart';

class ScanManual extends StatefulWidget {
  ScanManual({super.key});

  @override
  State<ScanManual> createState() => _ScanManualState();
}

class _ScanManualState extends State<ScanManual> {
  final Map<int, String> _items = {
    1: 'Fruit',
    2: 'Vegetable',
    3: 'Meat',
    4: 'Dairy',
    5: 'Grains',
    6: 'Seafood',
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();

  final TextEditingController _expiringDateController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _itemNameController.dispose();
    _expiringDateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: ColorValue.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorValue.gray.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Item Details",
                  style: tsTitleMediumSemibold(ColorValue.black),
                ),
                Text(
                  "Enter your food item information",
                  style: tsLabelLargeMedium(ColorValue.grayDark),
                ),
                const SizedBox(height: 20),

                Text("Item Name", style: tsBodySmallMedium(ColorValue.black)),
                const SizedBox(height: 10),
                CustomTextFormField(
                  label: "e.g., Organic Milk",
                  controller: _itemNameController,
                  textInputType: TextInputType.text,
                  validator: (value) => Validator.emptyValidator(
                    value: value,
                    message: "Item name must be filled",
                  ),
                ),

                const SizedBox(height: 20),
                Text("Category", style: tsBodySmallMedium(ColorValue.black)),
                const SizedBox(height: 10),
                DropdownCategory(),

                const SizedBox(height: 20),
                Text("Expiry Date", style: tsBodySmallMedium(ColorValue.black)),
                const SizedBox(height: 10),
                CustomTextFormField(
                  label: "Pick a date",
                  controller: _expiringDateController,
                  textInputType: TextInputType.datetime,
                  readOnly: true,
                  validator: (value) => Validator.emptyValidator(
                    value: value,
                    message: "Expiry date must be filled",
                  ),
                ),

                const SizedBox(height: 20),
                Text("Stored At", style: tsBodySmallMedium(ColorValue.black)),
                const SizedBox(height: 10),
                CustomTextFormField(
                  label: "e.g., Fridge",
                  controller: _locationController,
                  textInputType: TextInputType.text,
                  validator: (value) => Validator.emptyValidator(
                    value: value,
                    message: "Stored at must be filled",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          BlocConsumer<ScanBloc, ScanState>(
            listener: (context, state) {
              print(state.scanStatus);
              if (state.scanStatus == ScanStatus.success) {
                // context.read<ScanBloc>().add(
                //   GetChangeStatusEvent(status: ScanStatus.initial),
                // );

                print("halo");
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.success(
                    message: 'anda berhasil menambahkan pantry',
                  ),
                );
              } else if (state.scanStatus == ScanStatus.error) {}
            },
            builder: (context, state) {
              return MyButton(
                widget: state.scanStatus == ScanStatus.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Scan",
                        style: tsBodyMediumMedium(ColorValue.whiteColor),
                      ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ScanBloc>().add(
                      GetScanEvent(
                        item_name: _itemNameController.text,
                        expiring_date: _expiringDateController.text,
                        category: _items[state.category_id]!,
                        location: _locationController.text,
                      ),
                    );
                  }
                },
                height: 50,
                colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
                width: double.infinity,
              );
            },
          ),
        ],
      ),
    );
  }
}
