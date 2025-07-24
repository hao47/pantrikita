import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget widget;
  final Function() onPressed;
  final WidgetStateProperty<Color?> colorbtn;
  final double width;
  final double height;
  final bool? isOutlined;
  final Color? borderColor;

  const MyButton({
    super.key,
    required this.widget,
    required this.width,
    this.height = 50,
    required this.onPressed,
    required this.colorbtn,
    this.isOutlined,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool outlined = isOutlined ?? false;

    if (outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(Size(width, height)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          side: WidgetStateProperty.all(
            BorderSide(color: borderColor ?? Colors.grey),
          ),
          backgroundColor: colorbtn,
        ),
        child: widget,
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(Size(width, height)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: colorbtn,
        ),
        child: widget,
      );
    }
  }
}