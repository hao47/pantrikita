import 'package:flutter/material.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/widgets/bottom_navigation.dart';
import 'package:pantrikita/core/widgets/button.dart';
import 'package:pantrikita/feature/recipe/presentation/pages/recipe_detail_page.dart';
import 'package:pantrikita/feature/recipe/service/bookmark_service.dart';

class SavedRecipesPage extends StatefulWidget {
  const SavedRecipesPage({super.key});

  @override
  State<SavedRecipesPage> createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  final BookmarkService _bookmarkService = BookmarkService();
  List<SavedRecipe> _savedRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedRecipes();
  }

  Future<void> _loadSavedRecipes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final recipes = await _bookmarkService.getSavedRecipes();
      if (mounted) {
        setState(() {
          _savedRecipes = recipes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _removeRecipe(SavedRecipe recipe) async {
    final success = await _bookmarkService.removeRecipe(recipe.id);

    if (success && mounted) {
      setState(() {
        _savedRecipes.removeWhere((r) => r.id == recipe.id);
      });


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
          'Saved Recipes',
          style: tsTitleMediumBold(ColorValue.black),
        ),
        centerTitle: true,
        actions: [
          if (_savedRecipes.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete, color: ColorValue.black),
              onPressed: _showClearAllDialog,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedRecipes.isEmpty
          ? _buildEmptyState()
          : _buildSavedRecipesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 80,
              color: ColorValue.black,
            ),
            const SizedBox(height: 24),
            Text(
              'No Saved Recipes',
              style: tsTitleMediumBold(ColorValue.black),
            ),
            const SizedBox(height: 16),
            Text(
              'Save your favorite recipes by tapping the bookmark icon when viewing recipe details.',
              style: tsBodyMediumRegular(ColorValue.grayDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            MyButton(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Browse Recipes',
                    style: tsBodyMediumBold(Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                navigatorPushAndRemove(context, const BottomNavigation(index: 3));
              },
              colorbtn: WidgetStateProperty.all<Color>(ColorValue.primary),
              width: 200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedRecipesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _savedRecipes.length,
      itemBuilder: (context, index) {
        final recipe = _savedRecipes[index];
        return _buildRecipeCard(recipe);
      },
    );
  }

  Widget _buildRecipeCard(SavedRecipe recipe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
              Row(
                children: [
                  if (recipe.location != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorValue.primaryTransparant,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorValue.primary),
                      ),
                      child: Text(
                        recipe.location!,
                        style: tsBodySmallMedium(ColorValue.primary),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (recipe.difficulty != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getDifficultyBackgroundColor(recipe.difficulty),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        recipe.difficulty!,
                        style: tsBodySmallMedium(_getDifficultyColor(recipe.difficulty)),
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.orange, size: 20),
                    onPressed: () => _removeRecipe(recipe),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            recipe.title,
            style: tsTitleSmallBold(ColorValue.black),
          ),

          const SizedBox(height: 8),

          Text(
            recipe.description,
            style: tsBodySmallRegular(ColorValue.grayDark),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              if (recipe.cookTime != null) ...[
                const Icon(Icons.access_time, size: 14, color: ColorValue.grayDark),
                const SizedBox(width: 4),
                Text(recipe.cookTime!, style: tsBodySmallRegular(ColorValue.grayDark)),
                const SizedBox(width: 16),
              ],
              if (recipe.servingsPortion != null) ...[
                const Icon(Icons.people_outline, size: 14, color: ColorValue.grayDark),
                const SizedBox(width: 4),
                Text(recipe.servingsPortion!, style: tsBodySmallRegular(ColorValue.grayDark)),
                const SizedBox(width: 16),
              ],
              const Icon(Icons.bookmark, size: 14, color: ColorValue.grayDark),
              const SizedBox(width: 4),
              Text(
                _formatSavedDate(recipe.savedAt),
                style: tsBodySmallRegular(ColorValue.grayDark),
              ),
            ],
          ),

          const SizedBox(height: 16),

          MyButton(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.visibility, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  'View Recipe',
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

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: ColorValue.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                'Clear All Bookmarks?',
                style: tsTitleSmallSemibold(ColorValue.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Are you sure you want to remove all saved recipes? This action cannot be undone.',
                style: tsBodySmallRegular(ColorValue.grayDark),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      widget: Text(
                        'Cancel',
                        style: tsBodySmallMedium(ColorValue.grayDark),
                      ),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      colorbtn: WidgetStateProperty.all<Color>(Colors.transparent),
                      width: double.infinity,
                      height: 40,
                      isOutlined: true,
                      borderColor: ColorValue.gray,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MyButton(
                      widget: Text(
                        'Clear All',
                        style: tsBodySmallMedium(ColorValue.whiteColor),
                      ),
                      onPressed: () async {
                        Navigator.of(dialogContext).pop();
                        await _clearAllBookmarks();
                      },
                      colorbtn: WidgetStateProperty.all<Color>(ColorValue.red),
                      width: double.infinity,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _clearAllBookmarks() async {
    final success = await _bookmarkService.clearAllBookmarks();

    if (success && mounted) {
      setState(() {
        _savedRecipes.clear();
      });


    }
  }

  String _formatSavedDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return 'Just now';
    }
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