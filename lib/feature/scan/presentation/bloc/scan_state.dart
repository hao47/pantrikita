part of 'scan_bloc.dart';

enum ScanStatus { initial, loading, success, error }
enum IdentifyStatus { initial, loading, success, error }

class ScanState extends Equatable {
  const ScanState({
    this.change_tab_index = 1,
    this.category_id = 1,
    this.scanStatus = ScanStatus.initial,
    this.identifyStatus = IdentifyStatus.initial,
    this.scan,
    this.identify,
    this.message = '',
    this.item_name = '',
    this.category = '',
    this.expiring_date = '',
    this.location = '',
  });

  final ScanStatus scanStatus;
  final IdentifyStatus identifyStatus;

  final int change_tab_index;
  final int category_id;
  final Scan? scan;
  final Identify? identify;
  final String message;
  final String item_name;
  final String category;
  final String expiring_date;
  final String location;

  ScanState copyWith({
    int? change_tab_index,
    int? category_id,
    ScanStatus? scanStatus,
    IdentifyStatus? identifyStatus,
    Scan? scan,
    Identify? identify,
    String? message,
    String? item_name,
    String? category,
    String? expiring_date,
    String? location,
  }) {
    return ScanState(
      change_tab_index: change_tab_index ?? this.change_tab_index,
      category_id: category_id ?? this.category_id,
      scanStatus: scanStatus ?? this.scanStatus,
      identifyStatus: identifyStatus ?? this.identifyStatus,
      scan: scan ?? this.scan,
      identify: identify ?? this.identify,
      message: message ?? this.message,
      item_name: item_name ?? this.item_name,
      category: category ?? this.category,
      expiring_date: expiring_date ?? this.expiring_date,
      location: location ?? this.location,
    );
  }

  @override
  List<Object> get props => [
    change_tab_index,
    category_id,
    scanStatus,
    identifyStatus,
    message,
    item_name,
    category,
    expiring_date,
    location,
  ];
}
