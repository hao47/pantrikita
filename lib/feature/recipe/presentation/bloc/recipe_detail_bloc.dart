import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failures.dart';
import '../../data/repositories/recipe_detail_repository.dart';
import '../../domain/entities/recipe_detail.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  RecipeDetailBloc({required RecipeDetailRepository repository})
      : _repository = repository,
        super(RecipeDetailInitial()) {
    on<GetRecipeDetailEvent>(_getRecipeDetailEventHandler);
    on<UpdateIngredientStatusEvent>(_updateIngredientStatusEventHandler);
  }

  final RecipeDetailRepository _repository;

  Future<void> _getRecipeDetailEventHandler(
      GetRecipeDetailEvent event,
      Emitter<RecipeDetailState> emit,
      ) async {
    try {
      emit(RecipeDetailLoading());

      final either = await _repository.getRecipeDetail(event.recipeId);

      await either.fold(
            (failure) async {
          print("❌ Recipe Detail repository returned failure: ${failure.runtimeType}");

          emit(RecipeDetailFailure(
            message: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {
          print("✅ Recipe Detail repository returned data: ${data.data.title}");

          emit(RecipeDetailSuccess(
            recipeDetail: data,
          ));
        },
      );
    } catch (e) {
      print("💥 Recipe Detail BLoC error: $e");
      emit(RecipeDetailFailure(
        message: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }

  Future<void> _updateIngredientStatusEventHandler(
      UpdateIngredientStatusEvent event,
      Emitter<RecipeDetailState> emit,
      ) async {
    try {
      print("🔄 Updating ingredient: ${event.ingredientName} to ${event.isChecked}");

      final either = await _repository.updateIngredientStatus(
        event.recipeId,
        event.ingredientName,
        event.isChecked,
      );

      await either.fold(
            (failure) async {
          print("❌ Update Ingredient repository returned failure: ${failure.runtimeType}");

          emit(RecipeDetailIngredientUpdateFailure(
            message: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (success) async {
          print("✅ Update Ingredient repository returned success");

          if (state is RecipeDetailSuccess) {
            final currentState = state as RecipeDetailSuccess;
            final updatedRecipeDetail = _updateIngredientInRecipeDetail(
              currentState.recipeDetail,
              event.ingredientName,
              event.isChecked,
            );

            emit(RecipeDetailSuccess(
              recipeDetail: updatedRecipeDetail,
            ));
          }
        },
      );
    } catch (e) {
      print("💥 Update Ingredient BLoC error: $e");
      emit(RecipeDetailIngredientUpdateFailure(
        message: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }

  RecipeDetail _updateIngredientInRecipeDetail(RecipeDetail recipeDetail, String ingredientName, bool isChecked) {
    final updatedData = RecipeDetailData(
      id: recipeDetail.data.id,
      title: recipeDetail.data.title,
      description: recipeDetail.data.description,
      difficulty: recipeDetail.data.difficulty,
      culturalHeritage: recipeDetail.data.culturalHeritage,
      location: recipeDetail.data.location,
      cookTime: recipeDetail.data.cookTime,
      servingsPortion: recipeDetail.data.servingsPortion,
      ingredients: recipeDetail.data.ingredients.map((ingredient) {
        if (ingredient.name == ingredientName) {
          return DetailIngredient(
            id: ingredient.id,
            name: ingredient.name,
            isCheck: isChecked,
          );
        }
        return ingredient;
      }).toList(),
      instructions: recipeDetail.data.instructions,
    );

    return RecipeDetail(
      status: recipeDetail.status,
      data: updatedData,
    );
  }
}