import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      body: SafeArea(
          child: Text("HomePage")
      )
    );
  }
}
