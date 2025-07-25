import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/feature/pantry_detail/data/data_sources/repositories/pantry_detail_repository.dart';
import 'package:pantrikita/feature/pantry_detail/data/domain/entities/pantry_detail.dart';

part 'pantry_detail_event.dart';
part 'pantry_detail_state.dart';

class PantryDetailBloc extends Bloc<PantryDetailEvent, PantryDetailState> {
  PantryDetailBloc({required PantryDetailRepository repository}) : _repository = repository, super(PantryDetailState()) {
    on<GetPantryDetailEvent>(_getPantryDetailEventHandler);
    on<PutPantryDetailEvent>(_putPantryDetailEventHandler);
    on<DeletePantryDetailEvent>(_deletePantryDetailEventHandler);
    on<GetChangeTabIndexEvent>(_onChangeTabIndex);
  }

  final PantryDetailRepository _repository;

  Future<void> _getPantryDetailEventHandler(
      GetPantryDetailEvent event,
      Emitter<PantryDetailState> emit,
      ) async {
    try {
      emit(state.copyWith(
        pantryDetailStatus: PantryDetailStatus.loading,
      ));

      final either = await _repository.getPantryDetail(id: event.pantryId);

      await either.fold(
            (failure) async {

          emit(state.copyWith(
            pantryDetailStatus: PantryDetailStatus.failure,
            failureMessage: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {

          emit(state.copyWith(
            pantryDetailStatus: PantryDetailStatus.success,
            pantryDetailResponse: data,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        pantryDetailStatus: PantryDetailStatus.failure,
        failureMessage: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }

  Future<void> _putPantryDetailEventHandler(
      PutPantryDetailEvent event,
      Emitter<PantryDetailState> emit,
      ) async {
    try {
      emit(state.copyWith(
        pantryDetailStatus: PantryDetailStatus.loading,
      ));

      final either = await _repository.putPantryDetail(id: event.pantryId, status: event.status);

      await either.fold(
            (failure) async {

          emit(state.copyWith(
            pantryDetailStatus: PantryDetailStatus.failure,
            failureMessage: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {

          emit(state.copyWith(
            pantryDetailStatus: PantryDetailStatus.success,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        pantryDetailStatus: PantryDetailStatus.failure,
        failureMessage: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }

  Future<void> _deletePantryDetailEventHandler(
      DeletePantryDetailEvent event,
      Emitter<PantryDetailState> emit,
      ) async {
    try {
      emit(state.copyWith(
        pantryDetailStatus: PantryDetailStatus.loading,
      ));

      final either = await _repository.deletePantryDetail(id: event.pantryId);

      await either.fold(
            (failure) async {

          emit(state.copyWith(
            pantryDetailStatus: PantryDetailStatus.failure,
            failureMessage: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {

          emit(state.copyWith(
            pantryDetailStatus: PantryDetailStatus.success,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        pantryDetailStatus: PantryDetailStatus.failure,
        failureMessage: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }

  Future<void> _onChangeTabIndex(
      GetChangeTabIndexEvent event,
      Emitter<PantryDetailState> emit,
      ) async {
    emit(state.copyWith(changeTabIndex: event.changeTabIndex,));
  }

}