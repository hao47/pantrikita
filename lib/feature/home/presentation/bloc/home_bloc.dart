import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/feature/profile/data/repositories/profile_repository.dart';
import 'package:pantrikita/feature/profile/domain/entities/profile.dart';

import '../../data/repositories/home_repository.dart';
import '../../domain/entities/home.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required HomeRepository repository})
      : _repository = repository,
        super(HomeInitial()) {
    on<GetHomeEvent>(_getHomeEventHandler);

  }

  final HomeRepository _repository;

  Future<void> _getHomeEventHandler(
      GetHomeEvent event,
      Emitter<HomeState> emit,
      ) async {

      emit(HomeLoading());

      final either = await _repository.getHome();

      await either.fold(
            (failure) async {

          emit(HomeFailure(
            message: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {

          emit(HomeSuccess(
            home: data,
          ));
        },
      );

  }


}