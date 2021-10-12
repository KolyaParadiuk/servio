import 'package:json_annotation/json_annotation.dart';
import 'package:servio/constants/api_constants.dart';

part 'digest.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Digest<T> {
  @JsonKey(name: kBaseExternalID)
  final int baseExternalId;

  @JsonKey(name: kTitleBase)
  final String title;

  @JsonKey(name: kSourceType)
  final int sourceType;

  Digest({
    required this.baseExternalId,
    required this.title,
    required this.sourceType,
  });

  factory Digest.fromJson(Map<String, dynamic> json) => _$DigestFromJson<T>(json);

  Map<String, dynamic> toJson() => _$DigestToJson<T>(this);
}

@JsonSerializable(explicitToJson: true)
class HotelDigest extends Digest<HotelDigestData> {
  @JsonKey(name: kData)
  final List<HotelDigestData> data;
  @JsonKey(name: kSummary)
  final HotelDigestData summary;
  HotelDigest({
    required baseExternalId,
    required title,
    required sourceType,
    required this.data,
    required this.summary,
  }) : super(
          title: title,
          baseExternalId: baseExternalId,
          sourceType: sourceType,
        );
  factory HotelDigest.fromJson(Map<String, dynamic> json) => _$HotelDigestFromJson(json);

  Map<String, dynamic> toJson() => _$HotelDigestToJson(this);
}

@JsonSerializable()
class HotelDigestData {
  @JsonKey(name: kLoading)
  final loading;

  @JsonKey(name: kDate)
  final DateTime? date;

  @JsonKey(name: kDayOfWeekTitle)
  final String? dayOfWeekTitle;

  @JsonKey(name: kRoomsInExploitation)
  final int roomsInExploitation;

  @JsonKey(name: kRoomsInSale)
  final int roomsInSale;

  @JsonKey(name: kRoomsOnRepairNotSale)
  final int roomsOnRepairNotSale;

  @JsonKey(name: kRoomsInServiceUse)
  final int roomsInServiceUse;

  @JsonKey(name: kRoomsOccupied)
  final int roomsOccupied;

  @JsonKey(name: kCoefficientRooms)
  final double coefficientRooms;

  @JsonKey(name: kDwellingPayment)
  final double dwellingPayment;

  @JsonKey(name: kSOT)
  final double? sot;

  @JsonKey(name: kAvrOnAllRoom)
  final double avrOnAllRoom;
  @JsonKey(name: kIsShadow)
  final bool? isShadow;
  HotelDigestData(
      {this.loading,
      this.date,
      this.dayOfWeekTitle,
      required this.roomsInExploitation,
      required this.roomsInSale,
      required this.roomsOnRepairNotSale,
      required this.roomsInServiceUse,
      required this.roomsOccupied,
      required this.avrOnAllRoom,
      required this.coefficientRooms,
      required this.dwellingPayment,
      this.isShadow,
      this.sot});
  factory HotelDigestData.fromJson(Map<String, dynamic> json) => _$HotelDigestDataFromJson(json);

  Map<String, dynamic> toJson() => _$HotelDigestDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantDigest extends Digest<RestaurantDigestData> {
  @JsonKey(name: kData)
  final List<RestaurantDigestData> data;
  @JsonKey(name: kSummary)
  final RestaurantDigestData summary;
  RestaurantDigest({
    required baseExternalId,
    required title,
    required sourceType,
    required this.data,
    required this.summary,
  }) : super(
          title: title,
          baseExternalId: baseExternalId,
          sourceType: sourceType,
        );
  factory RestaurantDigest.fromJson(Map<String, dynamic> json) => _$RestaurantDigestFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDigestToJson(this);
}

@JsonSerializable()
class RestaurantDigestData {
  @JsonKey(name: kClosedDate)
  final DateTime? closedDate;

  @JsonKey(name: kGuestsCount)
  final int guestsCount;

  @JsonKey(name: kBillsCount)
  final int billsCount;

  @JsonKey(name: kBillTotal)
  final double billTotal;

  @JsonKey(name: kGuestTotal)
  final double guestTotal;

  @JsonKey(name: kProceeds)
  final double proceeds;

  @JsonKey(name: kIsShadow)
  final bool? isShadow;

  @JsonKey(name: kBaseExternalID)
  final int baseExternalID;

  RestaurantDigestData({
    this.closedDate,
    required this.guestsCount,
    required this.billsCount,
    required this.billTotal,
    required this.guestTotal,
    required this.proceeds,
    this.isShadow,
    required this.baseExternalID,
  });
  factory RestaurantDigestData.fromJson(Map<String, dynamic> json) => _$RestaurantDigestDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDigestDataToJson(this);
}
