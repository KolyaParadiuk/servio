part of 'digests_bloc.dart';

@immutable
abstract class DigestsState extends Equatable {
  @override
  List<Object> get props => [];
}

class DigestsInitial extends DigestsState {}

class DataLoading extends DigestsState {}

class DigestData extends DigestsState {
  final DateTime from;
  final DateTime to;
  DigestData({
    required this.from,
    required this.to,
  });
  @override
  List<Object> get props => [from, to];
}
