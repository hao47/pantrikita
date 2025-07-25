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


