part of 'digests_bloc.dart';

@immutable
abstract class DigestsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDataSources extends DigestsEvent {}

class LoadDigest extends DigestsEvent {}

class ChangeTimeFrom extends DigestsEvent {
  final DateTime date;
  ChangeTimeFrom(this.date);
}

class ChangeTimeTo extends DigestsEvent {
  final DateTime date;
  ChangeTimeTo(this.date);
}

class SwitchTodayDigestCheckbox extends DigestsEvent {
  final bool value;
  SwitchTodayDigestCheckbox(this.value);
}

class SwitchWeekDigestCheckbox extends DigestsEvent {
  final bool value;
  SwitchWeekDigestCheckbox(this.value);
}

class SwitchMonthDigestCheckbox extends DigestsEvent {
  final bool value;
  SwitchMonthDigestCheckbox(this.value);
}
