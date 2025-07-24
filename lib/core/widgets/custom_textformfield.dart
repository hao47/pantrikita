import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  final Future<String?> Function(String? value)? onChanged;
  final void Function()? onTap;
  final bool isPassword;
  final bool readOnly;
  final double borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initial;
  final bool? isNik;
  final Color fillColor;
  final double vpadding;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.isNik,
    this.initial,
    this.onTap,
    this.fillColor = Colors.white,
    this.isPassword = false,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.vpadding = 15,
    this.borderRadius = 14,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      widget.controller.text = DateFormat('yyyy/MM/dd').format(selectedDate);
    }
  }

  bool _isPasswordNotVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChanged);
    super.dispose();
  }

  void _handleTextChanged() {
    if (widget.isNik == true && widget.controller.text.length > 16) {
      widget.controller.text = widget.controller.text.substring(0, 16);
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.readOnly ? () => _selectDate(context) : widget.onTap,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      onChanged: (value) async {
        if (widget.isNik == true && value.length >= 16) {}
      },
      initialValue: widget.initial,

      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isPassword ? _isPasswordNotVisible : false,
      autocorrect: !widget.isPassword,
      enableSuggestions: !widget.isPassword,
      style: tsBodySmallMedium(ColorValue.black),
      cursorColor: ColorValue.gray,
      readOnly: widget.readOnly,

      decoration: InputDecoration(
        hintText: widget.label,
        filled: true, // harus ada ini agar fillColor aktif
        fillColor: widget.fillColor, // warna background input
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: Color(0xff666666)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: ColorValue.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: ColorValue.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),

        contentPadding: EdgeInsets.symmetric(
          vertical: widget.vpadding,
          horizontal: 20,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                splashRadius: 30,
                onPressed: () {
                  setState(() {
                    _isPasswordNotVisible = !_isPasswordNotVisible;
                  });
                },
                icon: !_isPasswordNotVisible
                    ? const Icon(Icons.visibility, color: ColorValue.gray)
                    : const Icon(Icons.visibility_off, color: ColorValue.gray),
              )
            : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
}
