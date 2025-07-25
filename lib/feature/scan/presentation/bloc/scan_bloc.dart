import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pantrikita/feature/scan/domain/entities/identify.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/register.dart';
import '../../../auth/presentation/bloc/register_bloc.dart';
import '../../data/repositories/scan_repository.dart';
import '../../domain/entities/scan.dart';


part 'scan_event.dart';

part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {

  final ScanRepository _repository;

  ScanBloc({required ScanRepository repository})
      : _repository = repository,
        super(const ScanState()) {
    on<GetTabIndexEvent>(_onChangeTabIndex);
    on<GetCategoryIdEvent>(_onChangeCategoryId);
    on<GetInitialTabEvent>(_onInitialIndex);
    on<GetScanEvent>(_getScanEventHandler);
    on<PhotoClasifier>(_photoClassifierHandler);
    on<GetScanSaveStateEvent>(_getSaveState);

  }

  Future<void> _onInitialIndex(
      GetInitialTabEvent event,
      Emitter<ScanState> emit,
      ) async {
    emit(state.copyWith(change_tab_index: 1));
  }

  Future<void> _onChangeTabIndex(
      GetTabIndexEvent event,
      Emitter<ScanState> emit,
      ) async {
    emit(state.copyWith(change_tab_index: event.change_tab));
  }
  Future<void> _onChangeCategoryId(
      GetCategoryIdEvent event,
      Emitter<ScanState> emit,
      ) async {
    emit(state.copyWith(category_id: event.categoryId));
  }


  Future<void> _getSaveState(
      GetScanSaveStateEvent event,
      Emitter<ScanState> emit,
      ) async {
    emit(state.copyWith(item_name: event.item_name,location: event.location,category: event.category,expiring_date: event.expiring_date,category_id: event.categoryId));


  }

  Future<void> _getScanEventHandler(
      GetScanEvent event,
      Emitter<ScanState> emit,
      ) async {
    emit(state.copyWith(scanStatus: ScanStatus.loading));

    print(event.location);
    print(event.expiring_date);
    print(event.category);
    print(event.item_name);

    final either = await _repository.postScan(
      event.item_name,
      event.category.toLowerCase(),
      event.expiring_date,
      event.location,
    );


    await _emitResult(either, emit);
  }

  Future<void> _emitResult(
      Either<Failure, Scan> either,
      Emitter<ScanState> emit,
      ) async {
    await either.fold(
          (failure) async {
        emit(
          state.copyWith(
            scanStatus: ScanStatus.error,
            message: mapFailureToMessage(failure),
          ),
        );
      },
          (data) {
        emit(state.copyWith(scan: data, scanStatus: ScanStatus.success));
      },
    );
  }


  Future<void> _photoClassifierHandler(
      PhotoClasifier event,
      Emitter emit,
      ) async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: ImageSource.camera ,
    );

    if(image != null){

      emit(state.copyWith(identifyStatus: IdentifyStatus.loading));

      final either = await _repository.postIdentify(image!);


      await either.fold(
            (failure) async {
          emit(
            state.copyWith(
              identifyStatus: IdentifyStatus.error,
              message: mapFailureToMessage(failure),
            ),
          );
        },
            (data) {
          emit(state.copyWith(identify: data, identifyStatus: IdentifyStatus.success));
        },
      );

    }



  }


}
