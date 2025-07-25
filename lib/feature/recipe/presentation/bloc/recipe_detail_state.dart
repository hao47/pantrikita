part of 'recipe_detail_bloc.dart';

@immutable
abstract class RecipeDetailState {}

class RecipeDetailInitial extends RecipeDetailState {}

class RecipeDetailLoading extends RecipeDetailState {}

class RecipeDetailSuccess extends RecipeDetailState {
  final RecipeDetail recipeDetail;

  RecipeDetailSuccess({
    required this.recipeDetail,
  });
}

class RecipeDetailFailure extends RecipeDetailState {
  final String message;
  final String? failureType;

  RecipeDetailFailure({
    required this.message,
    this.failureType,
  });
}

class RecipeDetailIngredientUpdateFailure extends RecipeDetailState {
  final String message;
  final String? failureType;

  RecipeDetailIngredientUpdateFailure({
    required this.message,
    this.failureType,
  });
}