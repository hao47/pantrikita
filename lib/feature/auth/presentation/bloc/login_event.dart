part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class GetLoginEvent extends LoginEvent {

  GetLoginEvent({required this.email, required this.password});


  String email;
  String password;
}
