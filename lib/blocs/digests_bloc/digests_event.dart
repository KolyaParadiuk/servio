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
