import 'package:flutter/material.dart';
import 'package:pantrikita/feature/scan/presentation/widgets/scan_manual.dart';




class ScanContent extends StatelessWidget {
  int index;

  ScanContent({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {

    if (index == 1) {
      return Container();
    } else if (index == 2) {
      return Container();
    } else if(index == 3){

      return ScanManual();
    }else {
      return Container();
    }
  }
}
