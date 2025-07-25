part of 'scan_bloc.dart';


class ScanState extends Equatable {
  const ScanState({
    this.change_tab_index = 0,

  });



  final int change_tab_index;


  ScanState copyWith({
    int? change_tab_index,

  }) {
    return ScanState(
      change_tab_index: change_tab_index ?? this.change_tab_index,
    );
  }

  @override
  List<Object> get props => [
    change_tab_index,
  ];
}