import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/widgets/button.dart';
import 'package:pantrikita/feature/recipe/domain/entities/recipe_detail.dart';
import 'package:pantrikita/feature/recipe/service/bookmark_service.dart';
import '../bloc/recipe_detail_bloc.dart';

class RecipeDetailPage extends StatefulWidget {
  final String recipeId;

  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool _isSaved = false;
  final BookmarkService _bookmarkService = BookmarkService();

  @override
  void initState() {
    super.initState();
    // Load recipe detail on page load
    context.read<RecipeDetailBloc>().add(GetRecipeDetailEvent(recipeId: widget.recipeId));
    // Check bookmark status
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final isBookmarked = await _bookmarkService.isRecipeBookmarked(widget.recipeId);
    if (mounted) {
      setState(() {
        _isSaved = isBookmarked;
      });
    }
  }

  Future<void> _toggleBookmark(RecipeDetailData recipe) async {
    try {
      final savedRecipe = SavedRecipe.fromRecipeDetail(recipe);
      final success = await _bookmarkService.toggleBookmark(savedRecipe);

      if (success && mounted) {
        setState(() {
          _isSaved = !_isSaved;
        });

      }
    } catch (e) {
      print("💥 Error toggling bookmark: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorValue.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Recipe Detail',
          style: tsTitleMediumBold(ColorValue.black),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<RecipeDetailBloc, RecipeDetailState>(
        listener: (context, state) {
          if (state is RecipeDetailIngredientUpdateFailure) {
            print("💥 Error updating Ingredient");
          }
        },
        builder: (context, state) {
          if (state is RecipeDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecipeDetailSuccess) {
            return _buildSuccessContent(state.recipeDetail.data);
          } else if (state is RecipeDetailFailure) {
            return _buildErrorContent(state);
          } else if (state is RecipeDetailIngredientUpdateFailure) {
            // Continue showing content even after ingredient update failure
            if (context.read<RecipeDetailBloc>().state is RecipeDetailSuccess) {
              final successState = context.read<RecipeDetailBloc>().state as RecipeDetailSuccess;
              return _buildSuccessContent(successState.recipeDetail.data);
            }
            return _buildErrorContent(RecipeDetailFailure(
              message: state.message,
              failureType: state.failureType,
            ));
          }

          return const Center(
            child: Text('Unexpected state'),
          );
        },
      ),
    );
  }

  Widget _buildSuccessContent(RecipeDetailData recipe) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Location and Difficulty Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Location Badge
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

                    // Difficulty Badge
                    if (recipe.difficulty != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getDifficultyBackgroundColor(recipe.difficulty),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          recipe.difficulty!,
                          style: tsBodyMediumBold(_getDifficultyColor(recipe.difficulty)),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // Recipe Title
                Text(
                  recipe.title,
                  style: tsTitleLargeBold(ColorValue.black),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Recipe Description
                Text(
                  recipe.description,
                  style: tsBodyMediumRegular(ColorValue.grayDark),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Cook Time and Servings
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.access_time,
                              color: Colors.blue.shade600,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            recipe.cookTime ?? 'N/A',
                            style: tsBodyMediumBold(ColorValue.black),
                          ),
                          Text(
                            'Cook Time',
                            style: tsBodySmallRegular(ColorValue.grayDark),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.people_outline,
                              color: Colors.purple.shade600,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            recipe.servingsPortion ?? 'N/A',
                            style: tsBodyMediumBold(ColorValue.black),
                          ),
                          Text(
                            'Portions',
                            style: tsBodySmallRegular(ColorValue.grayDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Save Recipe Button
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(12),
              color: _isSaved ? Colors.orange : Colors.white,
            ),
            child: InkWell(
              onTap: () => _toggleBookmark(recipe), // Fixed: Call the method properly
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: _isSaved ? Colors.white : Colors.orange,
                  size: 24,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Ingredients Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.emoji_food_beverage,
                      color: Colors.orange,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ingredients',
                      style: tsBodyLargeBold(ColorValue.black),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // You Have Ingredients
                ...recipe.youHave.map((ingredient) =>
                    _buildIngredientItem(ingredient, true)
                ).toList(),

                // You Need Ingredients
                ...recipe.youNeed.map((ingredient) =>
                    _buildIngredientItem(ingredient, false)
                ).toList(),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Instructions Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.menu_book,
                      color: Colors.orange,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Instructions',
                      style: tsBodyLargeBold(ColorValue.black),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Real Instructions from API
                if (recipe.instructions.isNotEmpty)
                  ...recipe.instructions.map((instruction) =>
                      _buildInstructionItem(instruction.step, instruction.description)
                  ).toList()
                else
                // Fallback if no instructions from API
                  ..._getMockInstructions().asMap().entries.map((entry) {
                    final index = entry.key;
                    final instruction = entry.value;
                    return _buildInstructionItem(index + 1, instruction);
                  }).toList(),
              ],
            ),
          ),

          // Cultural Heritage Section (if available)
          if (recipe.culturalHeritage != null && recipe.culturalHeritage!.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.history_edu,
                        color: Colors.orange,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Cultural Heritage',
                        style: tsBodyLargeBold(ColorValue.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    recipe.culturalHeritage!,
                    style: tsBodyMediumRegular(ColorValue.grayDark),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildErrorContent(RecipeDetailFailure state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              'Failed to Load Recipe',
              style: tsTitleMediumBold(ColorValue.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: tsBodyMediumRegular(ColorValue.grayDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            MyButton(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.refresh, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Try Again',
                    style: tsBodyMediumBold(Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                context.read<RecipeDetailBloc>().add(GetRecipeDetailEvent(recipeId: widget.recipeId));
              },
              colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientItem(DetailIngredient ingredient, bool youHave) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ingredient.isCheck
            ? Colors.green.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ingredient.isCheck
              ? Colors.green
              : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'i',
                style: tsBodySmallBold(Colors.grey.shade600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              ingredient.name,
              style: tsBodyMediumRegular(ColorValue.black),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Update ingredient status via BLoC
              context.read<RecipeDetailBloc>().add(UpdateIngredientStatusEvent(
                recipeId: widget.recipeId,
                ingredientName: ingredient.name,
                isChecked: !ingredient.isCheck,
              ));
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ingredient.isCheck ? Colors.green : Colors.white,
                border: Border.all(
                  color: ingredient.isCheck ? Colors.green : Colors.grey.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ingredient.isCheck
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(int step, String instruction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '$step',
                style: tsBodySmallBold(Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: tsBodyMediumRegular(ColorValue.grayDark),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getMockInstructions() {
    return [
      "Clean and cut young jackfruit into small pieces that can be eat by deka and dapa",
      "Clean and cut young jackfruit into small pieces that can be eat by deka and dapa",
      "Clean and cut young jackfruit into small pieces that can be eat by deka and dapa",
      "Clean and cut young jackfruit into small pieces that can be eat by deka and dapa",
      "Clean and cut young jackfruit into small pieces that can be eat by deka and dapa",
      "Clean and cut young jackfruit into small pieces that can be eat by deka and dapa",
    ];
  }

  Color _getDifficultyColor(String? difficulty) {
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

  Color _getDifficultyBackgroundColor(String? difficulty) {
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
}