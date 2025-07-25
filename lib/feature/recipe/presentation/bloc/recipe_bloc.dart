import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/feature/recipe/data/repositories/recipe_repository.dart';
import 'package:pantrikita/feature/recipe/domain/entities/recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc({required RecipeRepository repository})
      : _repository = repository,
        super(RecipeInitial()) {
    on<GetRecipesEvent>(_getRecipesEventHandler);
    on<RegenerateRecipesEvent>(_regenerateRecipesEventHandler);
  }

  final RecipeRepository _repository;

  Future<void> _getRecipesEventHandler(
      GetRecipesEvent event,
      Emitter<RecipeState> emit,
      ) async {
    try {
      emit(RecipeLoading());

      final either = await _repository.getRecipes();

      await either.fold(
            (failure) async {

          emit(RecipeFailure(
            message: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {
          emit(RecipeSuccess(
            recipeResponse: data,
          ));
        },
      );
    } catch (e) {
      emit(RecipeFailure(
        message: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }

  Future<void> _regenerateRecipesEventHandler(
      RegenerateRecipesEvent event,
      Emitter<RecipeState> emit,
      ) async {
    try {
      emit(RecipeLoading());

      final either = await _repository.regenerateRecipes();

      await either.fold(
            (failure) async {

          emit(RecipeFailure(
            message: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {
          emit(RecipeSuccess(
            recipeResponse: data,
          ));
        },
      );
    } catch (e) {
      emit(RecipeFailure(
        message: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }
}