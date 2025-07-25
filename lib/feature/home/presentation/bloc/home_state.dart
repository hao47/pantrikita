part of 'home_bloc.dart';


@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Home home;

  HomeSuccess({
    required this.home,
  });
}

class HomeFailure extends HomeState {
  final String message;
  final String? failureType;

  HomeFailure({
    required this.message,
    this.failureType,
  });
}

