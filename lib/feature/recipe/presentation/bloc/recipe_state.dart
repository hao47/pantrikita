part of 'recipe_bloc.dart';

@immutable
abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeSuccess extends RecipeState {
  final Recipe recipeResponse;

  RecipeSuccess({
    required this.recipeResponse,
  });
}

class RecipeFailure extends RecipeState {
  final String message;
  final String? failureType;

  RecipeFailure({
    required this.message,
    this.failureType,
  });
}