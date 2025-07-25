part of 'pantry_detail_bloc.dart';

@immutable
abstract class PantryDetailEvent {}

class GetPantryDetailEvent extends PantryDetailEvent {
  final String pantryId;

  GetPantryDetailEvent({required this.pantryId});
}

class PutPantryDetailEvent extends PantryDetailEvent {
  final String pantryId;
  final String status;

  PutPantryDetailEvent({required this.pantryId, required this.status});
}

class DeletePantryDetailEvent extends PantryDetailEvent {
  final String pantryId;

  DeletePantryDetailEvent({required this.pantryId});
}

class GetChangeTabIndexEvent extends PantryDetailEvent {
  final int changeTabIndex;

  GetChangeTabIndexEvent({required this.changeTabIndex});
}