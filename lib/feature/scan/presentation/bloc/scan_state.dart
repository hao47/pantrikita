part of 'scan_bloc.dart';


enum ScanStatus { initial, loading, success, error }

class ScanState extends Equatable {
  const ScanState({
    this.change_tab_index = 0,
    this.category_id = 1,
    this.scanStatus = ScanStatus.initial,
    this.scan,
    this.message = '',
    this.item_name = '',
  });


  final ScanStatus scanStatus;

  final int change_tab_index;
  final int category_id;
  final Scan? scan;
  final String message;
  final String item_name;

  ScanState copyWith({
    int? change_tab_index,
    int? category_id,
    ScanStatus? scanStatus,
    Scan? scan,
    String? message,
    String? item_name,

  }) {
    return ScanState(
      change_tab_index: change_tab_index ?? this.change_tab_index,
      category_id: category_id ?? this.category_id,
      scanStatus: scanStatus ?? this.scanStatus,
      scan: scan ?? this.scan,
      message: message ?? this.message,
      item_name: item_name ?? this.item_name,
    );
  }

  @override
  List<Object> get props => [
    change_tab_index,
    category_id,
    scanStatus,
    message,
    item_name,
  ];
}