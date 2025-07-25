import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/widgets/button.dart';
import 'package:pantrikita/feature/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:pantrikita/feature/recipe/presentation/pages/recipe_detail_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../recipe/domain/entities/recipe.dart';

class WidgetRecipeContent extends StatelessWidget {
  final RecipeSuccess state;

  const WidgetRecipeContent({super.key, required this.state});

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
                  onPressed: () {
                    context.read<RecipeBloc>().add(GetRecipesEvent());
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.info(message: "Regenerating recipes..."),
                    );
                  },
                  isOutlined: true,
                  borderColor: ColorValue.gray,
                  colorbtn: WidgetStateProperty.all<Color>(ColorValue.whiteColor),
                  width: 150,
                ),
              ),

              const SizedBox(height: 30),

              // Recipe List with Real Data
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.recipeResponse.data.length,
                itemBuilder: (context, index) {
                  final recipe = state.recipeResponse.data[index];
                  return _buildRecipeCard(context, recipe);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Data recipe) {
    // Helper function to get difficulty color
    Color getDifficultyColor(String? difficulty) {
      switch (difficulty?.toLowerCase()) {
        case 'easy':
          return ColorValue.green;
        case 'medium':
          return ColorValue.primary;
        case 'hard':
          return ColorValue.red;
        default:
          return ColorValue.grayDark;
      }
    }

    Color getDifficultyBackgroundColor(String? difficulty) {
      switch (difficulty?.toLowerCase()) {
        case 'easy':
          return ColorValue.greenStatusTransparant;
        case 'medium':
          return ColorValue.primaryTransparant;
        case 'hard':
          return ColorValue.redStatusTransparant;
        default:
          return ColorValue.grayTransparent;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorValue.grayTransparent,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
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
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorValue.primary),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_sharp, size: 16, color: ColorValue.primary),
                    const SizedBox(width: 5),
                    Text(
                      recipe.location ?? 'Unknown Location',
                      style: tsBodySmallMedium(ColorValue.primary),
                    ),
                  ],
                ),
              ),
              if (recipe.difficulty != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getDifficultyBackgroundColor(recipe.difficulty),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Text(
                        recipe.difficulty!,
                        style: tsBodySmallMedium(getDifficultyColor(recipe.difficulty)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            recipe.title,
            style: tsTitleSmallBold(ColorValue.black),
          ),
          const SizedBox(height: 8),

          Text(
            recipe.description,
            style: tsBodySmallRegular(ColorValue.grayDark),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: ColorValue.grayDark),
              const SizedBox(width: 4),
              Text(
                recipe.cookTime ?? 'N/A',
                style: tsBodySmallRegular(ColorValue.grayDark),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.people_outline, size: 16, color: ColorValue.grayDark),
              const SizedBox(width: 4),
              Text(
                recipe.servingsPortion ?? 'N/A',
                style: tsBodySmallRegular(ColorValue.grayDark),
              ),
            ],
          ),
          const SizedBox(height: 20),

          if (recipe.culturalHeritage != null && recipe.culturalHeritage!.isNotEmpty)
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
                    recipe.culturalHeritage!,
                    style: tsBodySmallRegular(ColorValue.primary),
                  ),
                ],
              ),
            ),

          if (recipe.culturalHeritage != null && recipe.culturalHeritage!.isNotEmpty)
            const SizedBox(height: 20),

          if (recipe.youHave.isNotEmpty) ...[
            Text(
              'You have:',
              style: tsBodyMediumSemibold(ColorValue.black),
            ),
            const SizedBox(height: 12),
            _buildIngredientTags(
              recipe.youHave.map((ingredient) => ingredient.name).toList(),
              true,
            ),
            const SizedBox(height: 16),
          ],

          // You'll need section
          if (recipe.youNeed.isNotEmpty) ...[
            Text(
              'You\'ll need:',
              style: tsBodyMediumSemibold(ColorValue.black),
            ),
            const SizedBox(height: 12),
            _buildIngredientTags(
              recipe.youNeed.map((ingredient) => ingredient.name).toList(),
              false,
            ),
            const SizedBox(height: 20),
          ],

          MyButton(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Learn & Cook This Recipe',
                  style: tsBodyMediumBold(Colors.white),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(recipeId: recipe.id),
                ),
              );
            },
            colorbtn: WidgetStateProperty.all<Color>(Colors.orange),
            width: double.infinity,
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
                : ColorValue.gray,
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