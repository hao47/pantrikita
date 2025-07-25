import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/feature/pantry/data/data_sources/repositories/pantry_repository.dart';
import 'package:pantrikita/feature/pantry/data/domain/entities/pantry.dart';

part 'pantry_event.dart';

part 'pantry_state.dart';

class PantryBloc extends Bloc<PantryEvent, PantryState> {
  PantryBloc({required PantryRepository repository}) : _repository = repository, super(PantryState()) {
    on<GetPantryEvent>(_getPantryEventHandler);
    on<GetFilterSearchEvent>(_onFilterSearch);
    on<GetFilterCategoryEvent>(_onFilterCategory);
    on<GetFilterStatusEvent>(_onFilterStatus);
    on<GetFilterSortEvent>(_onFilterSort);
  }

  final PantryRepository _repository;

  Future<void> _getPantryEventHandler(
      GetPantryEvent event,
      Emitter<PantryState> emit,
      ) async {
    try {
      emit(state.copyWith(
        pantryStatus: PantryStatus.loading,
      ));

      final either = await _repository.getPantry(
        search: state.filterSearch,
        category: state.filterCategory,
        status: state.filterStatus,
        filter: state.filterSort,
      );

      await either.fold(
            (failure) async {
          print("❌ Pantry repository returned failure: ${failure.runtimeType}");

          emit(state.copyWith(
            pantryStatus: PantryStatus.failure,
            failureMessage: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {
          print("✅ Pantry repository returned data");
          print("Data: ${data.toString()}");

          emit(state.copyWith(
            pantryStatus: PantryStatus.success,
            pantryResponse: data,
          ));
        },
      );
    } catch (e) {
      print("💥 Pantry BLoC error: $e");
      emit(state.copyWith(
        pantryStatus: PantryStatus.failure,
        failureMessage: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }

  Future<void> _onFilterSearch(
    GetFilterSearchEvent event,
    Emitter<PantryState> emit,
  ) async {
    emit(state.copyWith(filterSearch: event.filterSearch));
    await _getPantryEventHandler(GetPantryEvent(), emit);
  }

  Future<void> _onFilterCategory(
    GetFilterCategoryEvent event,
    Emitter<PantryState> emit,
  ) async {
    emit(state.copyWith(filterCategory: event.filterCategory));
    await _getPantryEventHandler(GetPantryEvent(), emit);
  }

  Future<void> _onFilterStatus(
    GetFilterStatusEvent event,
    Emitter<PantryState> emit,
  ) async {
    emit(state.copyWith(filterStatus: event.filterStatus));
    await _getPantryEventHandler(GetPantryEvent(), emit);
  }

  Future<void> _onFilterSort(
    GetFilterSortEvent event,
    Emitter<PantryState> emit,
  ) async {
    emit(state.copyWith(filterSort: event.filterSort));
    await _getPantryEventHandler(GetPantryEvent(), emit);
  }
}