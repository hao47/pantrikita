part of 'pantry_detail_bloc.dart';

@immutable
abstract class PantryDetailEvent {}

class GetPantryDetailEvent extends PantryDetailEvent {
  final String pantryId;

  GetPantryDetailEvent({required this.pantryId});
}

class GetChangeTabIndexEvent extends PantryDetailEvent {
  final int changeTabIndex;

  GetChangeTabIndexEvent({required this.changeTabIndex});
}