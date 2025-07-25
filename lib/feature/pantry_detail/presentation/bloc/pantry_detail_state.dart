part of 'pantry_detail_bloc.dart';

enum PantryDetailStatus { initial, loading, success, failure }

class PantryDetailState extends Equatable {
  const PantryDetailState({
    this.pantryDetailStatus = PantryDetailStatus.initial,
    this.failureMessage = '',
    this.failureType = '',
    this.changeTabIndex = 1,
  });

  final PantryDetailStatus pantryDetailStatus;
  final String failureMessage;
  final String failureType;

  final int changeTabIndex;


  PantryDetailState copyWith({
    PantryDetailStatus? pantryDetailStatus,
    String? failureMessage,
    String? failureType,
    int? changeTabIndex,
  }) {
    return PantryDetailState(
      pantryDetailStatus: pantryDetailStatus ?? this.pantryDetailStatus,
      failureMessage: failureMessage ?? this.failureMessage,
      failureType: failureType ?? this.failureType,
      changeTabIndex: changeTabIndex ?? this.changeTabIndex,
    );
  }

  @override
  List<Object> get props => [
    pantryDetailStatus,
    failureMessage,
    failureType,
    changeTabIndex,
  ];
}