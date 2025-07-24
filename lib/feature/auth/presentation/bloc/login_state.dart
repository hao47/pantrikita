part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess({required this.login});

  final Login login;
}

class LoginFailure extends LoginState {
  LoginFailure({required this.message});

  final String message;
}
