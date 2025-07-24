part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class GetRegisterEvent extends RegisterEvent {

  GetRegisterEvent({required this.email, required this.username, required this.password});


  String email;
  String username;
  String password;
}
