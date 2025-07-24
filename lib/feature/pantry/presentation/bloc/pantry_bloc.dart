import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pantry_event.dart';

part 'pantry_state.dart';

class PantryBloc extends Bloc<PantryEvent, PantryState> {
  PantryBloc() : super(PantryState()) {
    on<GetFilterSearchEvent>(_onFilterSearch);
    on<GetFilterCategoryEvent>(_onFilterCategory);
    on<GetFilterStatusEvent>(_onFilterStatus);
    on<GetFilterSortEvent>(_onFilterSort);
  }

  Future<void> _onFilterSearch(
      GetFilterSearchEvent event,
      Emitter<PantryState> emit,
      ) async {
    emit(state.copyWith(filterSearch: event.filterSearch));
  }

  Future<void> _onFilterCategory(
      GetFilterCategoryEvent event,
      Emitter<PantryState> emit,
      ) async {
    emit(state.copyWith(filterCategory: event.filterCategory));
  }

  Future<void> _onFilterStatus(
      GetFilterStatusEvent event,
      Emitter<PantryState> emit,
      ) async {
    emit(state.copyWith(filterStatus: event.filterStatus));
  }

  Future<void> _onFilterSort(
      GetFilterSortEvent event,
      Emitter<PantryState> emit,
      ) async {
    emit(state.copyWith(filterSort: event.filterSort));
  }
}