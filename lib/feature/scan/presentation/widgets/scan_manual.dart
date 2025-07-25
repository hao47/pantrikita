import 'package:flutter/material.dart';
import 'package:pantrikita/feature/scan/presentation/widgets/dropdown_category.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/theme/color_value.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/util/validator/validator.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/custom_textformfield.dart';


class ScanManual extends StatelessWidget {
   ScanManual({super.key});




  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _expiringDateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric( vertical: 20),
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
          MyButton(
            widget: Text(
              "Add to Pantry",
              style: tsBodyMediumMedium(ColorValue.whiteColor),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.success(
                    message: 'Successfully added an item to pantry!',
                  ),
                );

              }
            },
            height: 50,
            colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
