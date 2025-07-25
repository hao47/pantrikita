import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/feature/scan/presentation/widgets/scan_content.dart';
import 'package:pantrikita/feature/scan/presentation/widgets/scan_tab.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/theme/color_value.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/util/validator/validator.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/custom_textformfield.dart';
import '../bloc/scan_bloc.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: 20,
            ),
            child: BlocProvider(
              create: (context) => ScanBloc(),
              child: BlocBuilder<ScanBloc, ScanState>(
                builder: (context, state) {
                  final data = state.change_tab_index;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Scan',
                          style: tsTitleMediumBold(ColorValue.black),
                        ),
                      ),


                      ScanTab(onValueChanged: (v) {
                        print(v);
                        context.read<ScanBloc>().add(GetTabIndexEvent(change_tab: v));
                      }),


                      ScanContent(
                        index: data,
                      )



                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required IconData icon,
    required String label,
  }) {
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
              Icon(
                icon,
                size: 16,
                color: isSelected ? ColorValue.whiteColor : ColorValue.grayDark,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: tsBodySmallMedium(
                  isSelected ? ColorValue.whiteColor : ColorValue.grayDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  }

  // Widget _buildCameraScreen() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //     padding: const EdgeInsets.all(40),
  //     decoration: BoxDecoration(
  //       color: ColorValue.whiteColor,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: ColorValue.gray.withOpacity(0.3)),
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             color: ColorValue.greenStatusTransparant,
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           padding: const EdgeInsets.all(20),
  //           child: Icon(
  //             Icons.camera_alt_outlined,
  //             size: 50,
  //             color: ColorValue.green,
  //           ),
  //         ),
  //         const SizedBox(height: 20),
  //         Text("AI Recognition", style: tsBodyLargeMedium(ColorValue.black)),
  //         const SizedBox(height: 20),
  //         Text(
  //           "Take a photo let AI identify your food item automatically",
  //           style: tsBodySmallMedium(ColorValue.gray),
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: 20),
  //         MyButton(
  //           widget: Text(
  //             "Take Photo",
  //             style: tsBodySmallMedium(ColorValue.whiteColor),
  //           ),
  //           height: 55,
  //           onPressed: () {
  //             showTopSnackBar(
  //               Overlay.of(context),
  //               const CustomSnackBar.info(
  //                 message: "Camera feature coming soon!",
  //               ),
  //             );
  //           },
  //           colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
  //           width: 150,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildBarcodeScreen() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //     padding: const EdgeInsets.all(40),
  //     decoration: BoxDecoration(
  //       color: ColorValue.whiteColor,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: ColorValue.gray.withOpacity(0.3)),
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             color: ColorValue.blueTransparant,
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           padding: const EdgeInsets.all(20),
  //           child: Icon(
  //             Icons.qr_code_scanner,
  //             size: 50,
  //             color: ColorValue.blue,
  //           ),
  //         ),
  //         const SizedBox(height: 20),
  //         Text("Scan Barcode", style: tsBodyLargeMedium(ColorValue.black)),
  //         const SizedBox(height: 20),
  //         Text(
  //           "Point your camera at the product barcode for instant recognition",
  //           style: tsBodySmallMedium(ColorValue.gray),
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: 20),
  //         MyButton(
  //           widget: Text(
  //             "Start Scanning",
  //             style: tsBodySmallMedium(ColorValue.whiteColor),
  //           ),
  //           height: 55,
  //           onPressed: () {
  //             showTopSnackBar(
  //               Overlay.of(context),
  //               const CustomSnackBar.info(
  //                 message: "Barcode scanner coming soon!",
  //               ),
  //             );
  //           },
  //           colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
  //           width: 150,
  //         ),
  //       ],
  //     ),
  //   );
  // }








