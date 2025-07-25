import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/feature/pantry/data/data_sources/repositories/pantry_repository.dart';

part 'pantry_detail_event.dart';
part 'pantry_detail_state.dart';

class PantryDetailBloc extends Bloc<PantryDetailEvent, PantryDetailState> {
  PantryDetailBloc(): super(PantryDetailState()) {
    on<GetChangeTabIndexEvent>(_onChangeTabIndex);
  }

  Future<void> _onChangeTabIndex(
      GetChangeTabIndexEvent event,
      Emitter<PantryDetailState> emit,
      ) async {
    emit(state.copyWith(changeTabIndex: event.changeTabIndex,));
  }

}