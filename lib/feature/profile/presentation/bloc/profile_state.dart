part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final Profile profile;

  ProfileSuccess({
    required this.profile,
  });
}

class ProfileFailure extends ProfileState {
  final String message;
  final String? failureType;

  ProfileFailure({
    required this.message,
    this.failureType,
  });
}

class LogoutLoading extends ProfileState {}

class LogoutSuccess extends ProfileState {}

class LogoutFailure extends ProfileState {
  final String message;
  final String? failureType;

  LogoutFailure({
    required this.message,
    this.failureType,
  });
}