import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/widgets/button.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Recipes',
                  style: tsTitleMediumBold(ColorValue.black),
                ),
              ),
              const SizedBox(height: 30),

              Center(
                child: MyButton(
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.refresh, color: ColorValue.black, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Regenerate Recipes',
                        style: tsBodySmallMedium(ColorValue.black),
                      ),
                    ],
                  ),
                  onPressed: () {},
                  isOutlined: true,
                  borderColor: ColorValue.gray,
                  colorbtn: WidgetStateProperty.all<Color>(ColorValue.whiteColor),
                  width: 150,
                ),
              ),

              const SizedBox(height: 30),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return _buildRecipeCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorValue.grayTransparent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorValue.primaryTransparant,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorValue.primary),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_sharp, size: 16, color: ColorValue.primary),
                    Text(
                      'Yogyakarta',
                      style: tsBodySmallMedium(Colors.orange),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorValue.redStatusTransparant,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Hard',
                  style: tsBodySmallMedium(Colors.red),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            'Gudeg Jogja',
            style: tsTitleSmallBold(ColorValue.black),
          ),
          const SizedBox(height: 8),

          Text(
            'Traditional Javanese sweet jackfruit curry with coconut milk and palm sugar',
            style: tsBodySmallRegular(ColorValue.grayDark),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: ColorValue.grayDark),
              const SizedBox(width: 4),
              Text('180 min', style: tsBodySmallRegular(ColorValue.grayDark)),
              const SizedBox(width: 20),
              const Icon(Icons.people, size: 16, color: ColorValue.grayDark),
              const SizedBox(width: 4),
              Text('6 servings', style: tsBodySmallRegular(ColorValue.grayDark)),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorValue.primaryTransparant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cultural Heritage',
                  style: tsBodyMediumBold(ColorValue.primary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Originating from the Yogyakarta Sultanate, Gudeg was a favorite dish of the Sultan. The slow cooking process symbolizes Javanese patience and meticulousness.',
                  style: tsBodySmallRegular(ColorValue.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'You have:',
            style: tsBodyMediumSemibold(ColorValue.black),
          ),
          const SizedBox(height: 12),
          _buildIngredientTags(['Coconut Milk', 'Shallots'], true),
          const SizedBox(height: 16),

          Text(
            'You\'ll need:',
            style: tsBodyMediumSemibold(ColorValue.black),
          ),
          const SizedBox(height: 12),
          _buildIngredientTags(['Young Jackfruit', 'Palm Sugar', 'Galangal', 'Bay Leaves'], false),
          const SizedBox(height: 20),

          MyButton(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, color: ColorValue.whiteColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Learn & Cook This Recipe',
                  style: tsBodyMediumBold(ColorValue.whiteColor),
                ),
              ],
            ),
            onPressed: () {},
            colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
            width: double.infinity,
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientTags(List<String> ingredients, bool isAvailable) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ingredients.map((ingredient) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isAvailable
              ? ColorValue.greenStatusTransparant
              : ColorValue.grayTransparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isAvailable
                  ? ColorValue.green
                  : ColorValue.grayDark,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAvailable) ...[
              const Icon(Icons.check, size: 14, color: ColorValue.green),
              const SizedBox(width: 4),
            ],
            Text(
              ingredient,
              style: tsBodySmallMedium(
                  isAvailable ? ColorValue.green : ColorValue.grayDark
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}