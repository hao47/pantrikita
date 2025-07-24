import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';

import 'package:meta/meta.dart';
import 'package:pantrikita/feature/auth/data/data_sources/repository/auth_repository.dart';


import '../../../../core/error/failures.dart';
import '../../domain/entities/login.dart';


part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository repository})
      : _repository = repository,
        super(LoginInitial()) {
    on<GetLoginEvent>(_getHomeEventHandler);
  }

  final AuthRepository _repository;

  Future<void> _getHomeEventHandler(
      GetLoginEvent event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    final either =
    await _repository.getLogin(event.email, event.password);


    _emitResult(either, emit);
  }

  Future<void> _emitResult(
      Either<Failure, Login> either,
      Emitter<LoginState> emit,
      ) async {
    await either.fold(
          (failure) async {
        emit(
          LoginFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
          (data) {
        GetStorage().write("user_token", data.data.accessToken);


        emit(
          LoginSuccess(
            login: data,
          ),
        );
      },
    );
  }
}
