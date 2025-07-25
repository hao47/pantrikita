import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/theme/color_value.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/util/validator/validator.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/custom_textformfield.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  int selectedTab = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _expiringDateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final Map<int, String> _categories = {
    1: 'Fruit',
    2: 'Vegetable',
    3: 'Meat',
    4: 'Dairy',
    5: 'Grains',
    6: 'Seafood',
  };
  int _selectedCategoryId = 4;

  @override
  void dispose() {
    _itemNameController.dispose();
    _expiringDateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Scan',
                style: tsTitleMediumBold(ColorValue.black),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: ColorValue.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorValue.gray.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  _buildTabButton(index: 0, icon: Icons.qr_code_scanner, label: 'Barcode'),
                  _buildTabButton(index: 1, icon: Icons.camera_alt, label: 'Camera'),
                  _buildTabButton(index: 2, icon: Icons.edit, label: 'Manual'),
                ],
              ),
            ),

            Expanded(child: _buildContent()),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({required int index, required IconData icon, required String label}) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? ColorValue.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: isSelected ? ColorValue.whiteColor : ColorValue.grayDark),
              const SizedBox(width: 6),
              Text(
                label,
                style: tsBodySmallMedium(isSelected ? ColorValue.whiteColor : ColorValue.grayDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedTab) {
      case 0:
        return _buildBarcodeScreen();
      case 1:
        return _buildCameraScreen();
      case 2:
        return _buildManualScreen();
      default:
        return _buildCameraScreen();
    }
  }

  Widget _buildCameraScreen() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            child: Icon(Icons.camera_alt_outlined, size: 50, color: ColorValue.green),
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
          MyButton(
            widget: Text("Take Photo", style: tsBodySmallMedium(ColorValue.whiteColor)),
            height: 55,
            onPressed: () {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(message: "Camera feature coming soon!"),
              );
            },
            colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
            width: 150,
          ),
        ],
      ),
    );
  }


  Widget _buildBarcodeScreen() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              color: ColorValue.blueTransparant,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(20),
            child: Icon(Icons.qr_code_scanner, size: 50, color: ColorValue.blue),
          ),
          const SizedBox(height: 20),
          Text("Scan Barcode", style: tsBodyLargeMedium(ColorValue.black)),
          const SizedBox(height: 20),
          Text(
            "Point your camera at the product barcode for instant recognition",
            style: tsBodySmallMedium(ColorValue.gray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          MyButton(
            widget: Text("Start Scanning", style: tsBodySmallMedium(ColorValue.whiteColor)),
            height: 55,
            onPressed: () {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(message: "Barcode scanner coming soon!"),
              );
            },
            colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
            width: 150,
          ),
        ],
      ),
    );
  }


  Widget _buildManualScreen() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                Text("Item Details", style: tsTitleMediumSemibold(ColorValue.black)),
                Text("Enter your food item information", style: tsLabelLargeMedium(ColorValue.grayDark)),
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
                _buildDropdownCategory(),

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
                  onTap: () => _selectDate(context),
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

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MyButton(
              widget: Text("Add to Pantry", style: tsBodyMediumMedium(ColorValue.whiteColor)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.success(
                      message: 'Successfully added an item to pantry!',
                    ),
                  );
                  _clearForm();
                }
              },
              height: 50,
              colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDropdownCategory() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorValue.gray),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          dropdownColor: ColorValue.whiteColor,
          value: _selectedCategoryId,
          onChanged: (int? newValue) {
            setState(() => _selectedCategoryId = newValue!);
          },
          items: _categories.entries.map<DropdownMenuItem<int>>((entry) {
            return DropdownMenuItem<int>(
              value: entry.key,
              child: Text(entry.value, style: tsLabelLargeMedium(ColorValue.black)),
            );
          }).toList(),
          iconEnabledColor: ColorValue.black,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _expiringDateController.text =
        "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _clearForm() {
    _itemNameController.clear();
    _expiringDateController.clear();
    _locationController.clear();
    setState(() => _selectedCategoryId = 4);
  }
}
