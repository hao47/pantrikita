import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.hintName,
    required this.screenHeight,
    required this.screenWidth,
    required this.onSearch,
    required this.onClearSearch,
    required this.searchController,
  });

  final String hintName;
  final double screenHeight;
  final double screenWidth;
  final Function(String) onSearch;
  final TextEditingController searchController;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    double dpi = MediaQuery.of(context).devicePixelRatio * 170;
    TextStyle textStyleTitle = dpi < 380
        ? tsLabelLargeRegular(ColorValue.grayDark)
        : tsBodySmallRegular(ColorValue.grayDark);

    return SafeArea(
      child: Container(
        width: screenWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.only(left: 20, right: 8),
              decoration: BoxDecoration(
                color: ColorValue.silver,
                borderRadius: BorderRadius.circular(15),
              ),
              width: screenWidth * 0.9,
              child: TextField(
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    onClearSearch();
                  } else {
                    onSearch(value);
                  }
                },
                textAlignVertical: TextAlignVertical.center,
                controller: searchController,
                style: tsBodySmallRegular(ColorValue.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Color.fromRGBO(0, 0, 0, 100),
                          ),
                          onPressed: () {
                            searchController.clear();
                            onClearSearch();
                          },
                        )
                      : const Icon(
                          Icons.search,
                          color: Color.fromRGBO(0, 0, 0, 100),
                        ),
                  focusColor: const Color.fromRGBO(246, 246, 246, 100),
                  fillColor: const Color.fromRGBO(246, 246, 246, 100),
                  hintText: hintName,
                  hintStyle: textStyleTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
