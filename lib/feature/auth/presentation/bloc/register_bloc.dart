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
import '../../domain/entities/register.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthRepository repository})
      : _repository = repository,
        super(RegisterInitial()) {
    on<GetRegisterEvent>(_getHomeEventHandler);
  }

  final AuthRepository _repository;

  Future<void> _getHomeEventHandler(
      GetRegisterEvent event,
      Emitter<RegisterState> emit,
      ) async {
    emit(RegisterLoading());

    final either =
    await _repository.getRegister(event.email, event.password,event.username);


    _emitResult(either, emit);
  }

  Future<void> _emitResult(
      Either<Failure, Register> either,
      Emitter<RegisterState> emit,
      ) async {
    await either.fold(
          (failure) async {

            print(failure);
        emit(
          RegisterFailure(
            message: mapFailureToMessage(failure),
          ),
        );
      },
          (data) {



        emit(
          RegisterSuccess(
            register: data,
          ),
        );
      },
    );
  }
}
