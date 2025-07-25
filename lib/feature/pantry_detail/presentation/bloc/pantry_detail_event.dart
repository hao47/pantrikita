part of 'pantry_detail_bloc.dart';

@immutable
abstract class PantryDetailEvent {}

class GetChangeTabIndexEvent extends PantryDetailEvent {
  final int changeTabIndex;

  GetChangeTabIndexEvent({required this.changeTabIndex});
}