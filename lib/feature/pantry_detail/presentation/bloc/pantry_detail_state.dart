part of 'pantry_detail_bloc.dart';

enum PantryDetailStatus { initial, loading, success, failure }

class PantryDetailState extends Equatable {
  const PantryDetailState({
    this.pantryDetailStatus = PantryDetailStatus.initial,
    this.pantryDetailResponse,
    this.failureMessage = '',
    this.failureType = '',
    this.changeTabIndex = 1,
  });

  final PantryDetailStatus pantryDetailStatus;
  final PantryDetail? pantryDetailResponse;
  final String failureMessage;
  final String failureType;

  final int changeTabIndex;


  PantryDetailState copyWith({
    PantryDetailStatus? pantryDetailStatus,
    PantryDetail? pantryDetailResponse,
    String? failureMessage,
    String? failureType,
    int? changeTabIndex,
  }) {
    return PantryDetailState(
      pantryDetailStatus: pantryDetailStatus ?? this.pantryDetailStatus,
      pantryDetailResponse: pantryDetailResponse ?? this.pantryDetailResponse,
      failureMessage: failureMessage ?? this.failureMessage,
      failureType: failureType ?? this.failureType,
      changeTabIndex: changeTabIndex ?? this.changeTabIndex,
    );
  }

  @override
  List<Object> get props => [
    pantryDetailStatus,
    pantryDetailResponse ?? PantryDetail(
      data: Data(
        id: '',
        icon: '',
        name: '',
        category: '',
        headerStatus: Status(statusText: '', statusColor: ''),
        bodyStatus: Status(statusText: '', statusColor: ''),
        expiringDate: '',
        location: '',
        recipe: [],
        useEverything: [],
        composting: Composting(enviromentalImpact: '', orders: []),
      ),
    ),
    failureMessage,
    failureType,
    changeTabIndex,
  ];
}