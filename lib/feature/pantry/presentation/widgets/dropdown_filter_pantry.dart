import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class DropdownFilterPantry extends StatelessWidget {
  const DropdownFilterPantry({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  final Map<String, String> items;
  final String? selectedValue;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: ColorValue.silver,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          menuWidth: screenWidth * 0.5,
          dropdownColor: ColorValue.whiteColor,
          padding: EdgeInsets.only(left: screenWidth * 0.03, right: screenWidth * 0.01),
          borderRadius: BorderRadius.circular(15),
          elevation: 2,
          iconSize: 20,
          onChanged: (String? newValue) {
            print(newValue);
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          selectedItemBuilder: (BuildContext context) {
            return items.entries.map<Widget>((MapEntry<String, String> entry) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  entry.value,
                  style: tsLabelLargeRegular(ColorValue.black),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          },
          items: items.entries.map<DropdownMenuItem<String>>(
                (MapEntry<String, String> entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 10),
                  decoration: BoxDecoration(
                    color: entry.key == selectedValue ? ColorValue.primaryTransparant : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.value, style: tsLabelLargeRegular(ColorValue.black), overflow: TextOverflow.ellipsis),
                      if (entry.key == selectedValue)
                        Icon(Icons.check, color: ColorValue.primary, size: 20,),
                    ],
                  ),
                ),
              );
            },
          ).toList(),

        ),
      ),
    );
  }
}
