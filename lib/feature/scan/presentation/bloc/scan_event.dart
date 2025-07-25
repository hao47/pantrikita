part of 'scan_bloc.dart';

@immutable
abstract class ScanEvent {}


class GetTabIndexEvent extends ScanEvent {
  final int change_tab;

  GetTabIndexEvent({required this.change_tab});
}

