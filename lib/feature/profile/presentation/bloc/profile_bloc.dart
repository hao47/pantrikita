import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/error/failures.dart';
import 'package:pantrikita/feature/profile/data/repositories/profile_repository.dart';
import 'package:pantrikita/feature/profile/domain/entities/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository repository})
      : _repository = repository,
        super(ProfileInitial()) {
    on<GetProfileEvent>(_getProfileEventHandler);
    on<LogoutEvent>(_logoutEventHandler);
  }

  final ProfileRepository _repository;

  Future<void> _getProfileEventHandler(
      GetProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      emit(ProfileLoading());

      final either = await _repository.getProfile();

      await either.fold(
            (failure) async {

          emit(ProfileFailure(
            message: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (data) async {

          emit(ProfileSuccess(
            profile: data,
          ));
        },
      );
    } catch (e) {
      emit(ProfileFailure(
        message: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }

  Future<void> _logoutEventHandler(
      LogoutEvent event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      emit(LogoutLoading());

      final either = await _repository.logout();

      await either.fold(
            (failure) async {

          emit(LogoutFailure(
            message: mapFailureToMessage(failure),
            failureType: failure.runtimeType.toString(),
          ));
        },
            (success) async {

          if (success) {
            emit(LogoutSuccess());
          } else {
            emit(LogoutFailure(
              message: 'Logout failed. Please try again.',
              failureType: "LogoutFailure",
            ));
          }
        },
      );
    } catch (e) {
      emit(LogoutFailure(
        message: "An unexpected error occurred: $e",
        failureType: "UnknownFailure",
      ));
    }
  }
}