part of 'pantry_bloc.dart';

enum PantryStatus { initial, loading, success, failure }

class PantryState extends Equatable {
  const PantryState({
    this.filterSearch = '',
    this.filterCategory = 'all_categories',
    this.filterStatus = 'all_status',
    this.filterSort = 'expiry_date',
    this.pantryStatus = PantryStatus.initial,
    this.pantryResponse,
    this.failureMessage = '',
    this.failureType = '',
  });

  final String filterSearch;
  final String filterCategory;
  final String filterStatus;
  final String filterSort;

  final PantryStatus pantryStatus;
  final Pantry? pantryResponse;
  final String failureMessage;
  final String failureType;
  

  PantryState copyWith({
    String? filterSearch,
    String? filterCategory,
    String? filterStatus,
    String? filterSort,
    PantryStatus? pantryStatus,
    Pantry? pantryResponse,
    String? failureMessage,
    String? failureType,
  }) {
    return PantryState(
      filterSearch: filterSearch ?? this.filterSearch,
      filterCategory: filterCategory ?? this.filterCategory,
      filterStatus: filterStatus ?? this.filterStatus,
      filterSort: filterSort ?? this.filterSort,
      pantryStatus: pantryStatus ?? this.pantryStatus,
      pantryResponse: pantryResponse ?? this.pantryResponse,
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
    pantryResponse ?? Pantry(data: Data(totalItems: TotalItems(total: 0, fresh: 0, expiring: 0, expired: 0), items: [])),
    failureMessage,
    failureType,
  ];
}