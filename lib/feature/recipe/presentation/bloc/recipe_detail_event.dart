part of 'recipe_detail_bloc.dart';

@immutable
abstract class RecipeDetailEvent {}

class GetRecipeDetailEvent extends RecipeDetailEvent {
  final String recipeId;

  GetRecipeDetailEvent({required this.recipeId});
}

class UpdateIngredientStatusEvent extends RecipeDetailEvent {
  final String recipeId;
  final String ingredientName;
  final bool isChecked;

  UpdateIngredientStatusEvent({
    required this.recipeId,
    required this.ingredientName,
    required this.isChecked,
  });
}