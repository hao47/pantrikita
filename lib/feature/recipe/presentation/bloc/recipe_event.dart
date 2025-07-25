part of 'recipe_bloc.dart';

@immutable
abstract class RecipeEvent {}

class GetRecipesEvent extends RecipeEvent {}

class RegenerateRecipesEvent extends RecipeEvent {}