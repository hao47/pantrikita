import 'package:flutter/material.dart';
import 'package:pantrikita/feature/scan/presentation/widgets/scan_barcode.dart';
import 'package:pantrikita/feature/scan/presentation/widgets/scan_camera.dart';
import 'package:pantrikita/feature/scan/presentation/widgets/scan_manual.dart';




class ScanContent extends StatelessWidget {
  int index;

  ScanContent({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {

    if (index == 1) {
      return ScanBarcode();
    } else if (index == 2) {
      return ScanCamera();
    } else if(index == 3){

      return ScanManual();
    }else {
      return Container();
    }
  }
}
