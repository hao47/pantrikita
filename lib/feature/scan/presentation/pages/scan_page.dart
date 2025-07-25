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
import '../../../../injection-container.dart';
import '../bloc/scan_bloc.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
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
              create: (_) => sl.get<ScanBloc>()..add(GetInitialTabEvent()),
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

                      Text(
                        "Item Name",
                        style: tsBodySmallMedium(ColorValue.black),
                      ),
                      const SizedBox(height: 10),

                      ScanTab(
                        onValueChanged: (v) {
                          print(v);
                          context.read<ScanBloc>().add(
                            GetTabIndexEvent(change_tab: v),
                          );
                        },
                      ),

                      ScanContent(index: data),
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
}

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
