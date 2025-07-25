import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/register.dart';
import '../../../auth/presentation/bloc/register_bloc.dart';


part 'scan_event.dart';

part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {

  ScanBloc() : super(const ScanState()) {
    on<GetTabIndexEvent>(_onChangeTabIndex);
  }


  Future<void> _onChangeTabIndex(
      GetTabIndexEvent event,
      Emitter<ScanState> emit,
      ) async {
    emit(state.copyWith(change_tab_index: event.change_tab));
  }


}
