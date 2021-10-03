part of 'digests_bloc.dart';

@immutable
abstract class DigestsState extends Equatable {
  @override
  List<Object> get props => [];
}

class DigestsInitial extends DigestsState {}

class DigestData extends DigestsState {
  final DateTime from;
  final DateTime to;
  final List<HotelDigest> hotelDigest;
  final List<RestaurantDigest> restaurantDigest;
  final bool showLastDay;
  final bool showLastWeek;
  final bool showLastMonth;
  DigestData(
      {required this.from,
      required this.to,
      required this.hotelDigest,
      required this.restaurantDigest,
      required this.showLastDay,
      required this.showLastMonth,
      required this.showLastWeek});
  @override
  List<Object> get props => [
        from,
        to,
        hotelDigest,
        restaurantDigest,
        showLastDay,
        showLastWeek,
        showLastMonth,
      ];
}

class DataLoading extends DigestData {
  DataLoading({
    hotelDigest,
    restaurantDigest,
    from,
    to,
    showLastDay,
    showLastWeek,
    showLastMonth,
  }) : super(
          hotelDigest: hotelDigest ?? [],
          restaurantDigest: restaurantDigest ?? [],
          from: from ?? DateTime.now(),
          to: to ?? DateTime.now(),
          showLastDay: showLastDay ?? false,
          showLastWeek: showLastWeek ?? false,
          showLastMonth: showLastMonth ?? false,
        );

  factory DataLoading.fromDigestData(
    DigestData source, {
    from,
    to,
    showLastDay,
    showLastWeek,
    showLastMonth,
  }) {
    return DataLoading(
      hotelDigest: source.hotelDigest,
      restaurantDigest: source.restaurantDigest,
      from: from ?? source.from,
      to: to ?? source.to,
      showLastDay: showLastDay ?? source.showLastDay,
      showLastWeek: showLastWeek ?? source.showLastWeek,
      showLastMonth: showLastMonth ?? source.showLastMonth,
    );
  }
}
