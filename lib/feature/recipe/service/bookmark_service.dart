import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:pantrikita/feature/recipe/domain/entities/recipe_detail.dart';

class BookmarkService {
  static const String _bookmarkKey = 'saved_recipes';
  final GetStorage _storage = GetStorage();

  Future<bool> saveRecipe(SavedRecipe recipe) async {
    try {
      final bookmarks = await getSavedRecipes();

      if (bookmarks.any((saved) => saved.id == recipe.id)) {
        print("📖 Recipe already bookmarked: ${recipe.title}");
        return true;
      }

      bookmarks.add(recipe);
      await _storage.write(_bookmarkKey, json.encode(bookmarks.map((e) => e.toJson()).toList()));
      print("✅ Recipe bookmarked: ${recipe.title}");
      return true;
    } catch (e) {
      print("💥 Error saving bookmark: $e");
      return false;
    }
  }

  Future<bool> removeRecipe(String recipeId) async {
    try {
      final bookmarks = await getSavedRecipes();
      final initialLength = bookmarks.length;

      bookmarks.removeWhere((recipe) => recipe.id == recipeId);

      if (bookmarks.length < initialLength) {
        await _storage.write(_bookmarkKey, json.encode(bookmarks.map((e) => e.toJson()).toList()));
        print("✅ Recipe removed from bookmarks: $recipeId");
        return true;
      } else {
        print("⚠️ Recipe not found in bookmarks: $recipeId");
        return false;
      }
    } catch (e) {
      print("💥 Error removing bookmark: $e");
      return false;
    }
  }

  Future<bool> isRecipeBookmarked(String recipeId) async {
    try {
      final bookmarks = await getSavedRecipes();
      return bookmarks.any((recipe) => recipe.id == recipeId);
    } catch (e) {
      print("💥 Error checking bookmark status: $e");
      return false;
    }
  }

  Future<List<SavedRecipe>> getSavedRecipes() async {
    try {
      final data = _storage.read(_bookmarkKey);
      if (data == null) return [];

      final List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => SavedRecipe.fromJson(json)).toList();
    } catch (e) {
      print("💥 Error getting saved recipes: $e");
      return [];
    }
  }

  Future<bool> toggleBookmark(SavedRecipe recipe) async {
    final isBookmarked = await isRecipeBookmarked(recipe.id);

    if (isBookmarked) {
      return await removeRecipe(recipe.id);
    } else {
      return await saveRecipe(recipe);
    }
  }

  Future<bool> clearAllBookmarks() async {
    try {
      await _storage.remove(_bookmarkKey);
      print("✅ All bookmarks cleared");
      return true;
    } catch (e) {
      print("💥 Error clearing bookmarks: $e");
      return false;
    }
  }

  Future<int> getBookmarkCount() async {
    final bookmarks = await getSavedRecipes();
    return bookmarks.length;
  }
}

class SavedRecipe {
  final String id;
  final String title;
  final String description;
  final String? difficulty;
  final String? location;
  final String? cookTime;
  final String? servingsPortion;
  final DateTime savedAt;

  SavedRecipe({
    required this.id,
    required this.title,
    required this.description,
    this.difficulty,
    this.location,
    this.cookTime,
    this.servingsPortion,
    required this.savedAt,
  });

  factory SavedRecipe.fromJson(Map<String, dynamic> json) => SavedRecipe(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    difficulty: json['difficulty'],
    location: json['location'],
    cookTime: json['cook_time'],
    servingsPortion: json['servings_portion'],
    savedAt: DateTime.parse(json['saved_at'] ?? DateTime.now().toIso8601String()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'difficulty': difficulty,
    'location': location,
    'cook_time': cookTime,
    'servings_portion': servingsPortion,
    'saved_at': savedAt.toIso8601String(),
  };

  factory SavedRecipe.fromRecipeDetail(RecipeDetailData recipe) => SavedRecipe(
    id: recipe.id,
    title: recipe.title,
    description: recipe.description,
    difficulty: recipe.difficulty,
    location: recipe.location,
    cookTime: recipe.cookTime,
    servingsPortion: recipe.servingsPortion,
    savedAt: DateTime.now(),
  );
}