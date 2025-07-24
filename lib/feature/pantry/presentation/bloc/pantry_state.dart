part of 'pantry_bloc.dart';

enum PantryStatus { initial, loading, success, failure }

class PantryState extends Equatable {
  const PantryState({
    this.filterSearch = '',
    this.filterCategory = 'all_categories',
    this.filterStatus = 'all_status',
    this.filterSort = 'expiry_date',
    this.pantryStatus = PantryStatus.initial,
    this.failureMessage = '',
    this.failureType = '',
  });

  final String filterSearch;
  final String filterCategory;
  final String filterStatus;
  final String filterSort;

  final PantryStatus pantryStatus;
  final String failureMessage;
  final String failureType;


  PantryState copyWith({
    String? filterSearch,
    String? filterCategory,
    String? filterStatus,
    String? filterSort,
    PantryStatus? pantryStatus,
    String? failureMessage,
    String? failureType,
  }) {
    return PantryState(
      filterSearch: filterSearch ?? this.filterSearch,
      filterCategory: filterCategory ?? this.filterCategory,
      filterStatus: filterStatus ?? this.filterStatus,
      filterSort: filterSort ?? this.filterSort,
      pantryStatus: pantryStatus ?? this.pantryStatus,
      failureMessage: failureMessage ?? this.failureMessage,
      failureType: failureType ?? this.failureType,
    );
  }

  @override
  List<Object> get props => [
    filterSearch,
    filterCategory,
    filterStatus,
    filterSort,
    pantryStatus,
    failureMessage,
    failureType,
  ];
}