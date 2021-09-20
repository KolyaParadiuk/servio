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
  final List<HotelDigest> hotelDigest;
  final List<RestaurantDigest> restaurantDigest;
  DigestData({
    required this.from,
    required this.to,
    required this.hotelDigest,
    required this.restaurantDigest,
  });
  @override
  List<Object> get props => [from, to];
}
