part of 'pantry_bloc.dart';

@immutable
abstract class PantryEvent {}

class GetPantryEvent extends PantryEvent {}

class GetFilterSearchEvent extends PantryEvent {
  final String filterSearch;

  GetFilterSearchEvent({required this.filterSearch});
}

class GetFilterCategoryEvent extends PantryEvent {
  final String filterCategory;

  GetFilterCategoryEvent({required this.filterCategory});
}

class GetFilterStatusEvent extends PantryEvent {
  final String filterStatus;

  GetFilterStatusEvent({required this.filterStatus});
}

class GetFilterSortEvent extends PantryEvent {
  final String filterSort;

  GetFilterSortEvent({required this.filterSort});
}