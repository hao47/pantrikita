part of 'scan_bloc.dart';

@immutable
abstract class ScanEvent {}


class GetScanEvent extends ScanEvent {
  final String item_name;
  final String category;
  final String expiring_date;
  final String location;

  GetScanEvent({
    required this.item_name,
    required this.category,
    required this.expiring_date,
    required this.location,
  });
}

class GetTabIndexEvent extends ScanEvent {
  final int change_tab;

  GetTabIndexEvent({required this.change_tab});
}

class GetCategoryIdEvent extends ScanEvent {
  final int categoryId;

  GetCategoryIdEvent({required this.categoryId});
}

class GetChangeStatusEvent extends ScanEvent {
  final ScanStatus status;

  GetChangeStatusEvent({required this.status});
}


class GetInitialTabEvent extends ScanEvent {}

class PhotoClasifier extends ScanEvent {}


class GetScanSaveStateEvent extends ScanEvent {
  final String item_name;
  final String category;
  final String expiring_date;
  final String location;
  final int categoryId;

  GetScanSaveStateEvent({
    required this.item_name,
    required this.category,
    required this.expiring_date,
    required this.location,
    required this.categoryId,
  });
}

