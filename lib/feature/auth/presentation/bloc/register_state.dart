part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterSuccess({required this.register});

  final Register register;
}

class RegisterFailure extends RegisterState {
  RegisterFailure({required this.message});

  final String message;
}
