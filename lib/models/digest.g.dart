// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Digest _$DigestFromJson(Map<String, dynamic> json) {
  return Digest(
    baseExternalId: json['BaseExternalID'] as int,
    title: json['TitleBase'] as String,
    sourceType: json['SourceType'] as int,
  );
}

Map<String, dynamic> _$DigestToJson(Digest instance) => <String, dynamic>{
      'BaseExternalID': instance.baseExternalId,
      'TitleBase': instance.title,
      'SourceType': instance.sourceType,
    };

HotelDigest _$HotelDigestFromJson(Map<String, dynamic> json) {
  return HotelDigest(
    baseExternalId: json['BaseExternalID'],
    title: json['TitleBase'],
    sourceType: json['SourceType'],
    data: (json['Data'] as List<dynamic>)
        .map((e) => HotelDigestData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HotelDigestToJson(HotelDigest instance) =>
    <String, dynamic>{
      'BaseExternalID': instance.baseExternalId,
      'TitleBase': instance.title,
      'SourceType': instance.sourceType,
      'Data': instance.data.map((e) => e.toJson()).toList(),
    };

HotelDigestData _$HotelDigestDataFromJson(Map<String, dynamic> json) {
  return HotelDigestData(
    loading: json['Loading'],
    date: DateTime.parse(json['Date'] as String),
    dayOfWeekTitle: json['DayOfWeekTitle'] as String,
    roomsInExploitation: json['RoomsInExploitation'] as int,
    roomsInSale: json['RoomsInSale'] as int,
    roomsOnRepairNotSale: json['RoomsOnRepairNotSale'] as int,
    roomsInServiceUse: json['RoomsInServiceUse'] as int,
    roomsOccupied: json['RoomsOccupied'] as int,
    avrOnAllRoom: (json['AvrOnAllRoom'] as num).toDouble(),
    coefficientRooms: (json['CoefficientRooms'] as num).toDouble(),
    dwellingPayment: (json['DwellingPayment'] as num).toDouble(),
    sot: (json['SOT'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$HotelDigestDataToJson(HotelDigestData instance) =>
    <String, dynamic>{
      'Loading': instance.loading,
      'Date': instance.date.toIso8601String(),
      'DayOfWeekTitle': instance.dayOfWeekTitle,
      'RoomsInExploitation': instance.roomsInExploitation,
      'RoomsInSale': instance.roomsInSale,
      'RoomsOnRepairNotSale': instance.roomsOnRepairNotSale,
      'RoomsInServiceUse': instance.roomsInServiceUse,
      'RoomsOccupied': instance.roomsOccupied,
      'CoefficientRooms': instance.coefficientRooms,
      'DwellingPayment': instance.dwellingPayment,
      'SOT': instance.sot,
      'AvrOnAllRoom': instance.avrOnAllRoom,
    };

RestaurantDigest _$RestaurantDigestFromJson(Map<String, dynamic> json) {
  return RestaurantDigest(
    baseExternalId: json['BaseExternalID'],
    title: json['TitleBase'],
    sourceType: json['SourceType'],
    data: (json['Data'] as List<dynamic>)
        .map((e) => RestaurantDigestData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestaurantDigestToJson(RestaurantDigest instance) =>
    <String, dynamic>{
      'BaseExternalID': instance.baseExternalId,
      'TitleBase': instance.title,
      'SourceType': instance.sourceType,
      'Data': instance.data.map((e) => e.toJson()).toList(),
    };

RestaurantDigestData _$RestaurantDigestDataFromJson(Map<String, dynamic> json) {
  return RestaurantDigestData(
    closedDate: DateTime.parse(json['ClosedDate'] as String),
    guestsCount: json['GuestsCount'] as int,
    billsCount: json['BillsCount'] as int,
    billTotal: (json['BillTotal'] as num).toDouble(),
    guestTotal: (json['GuestTotal'] as num).toDouble(),
    proceeds: (json['Proceeds'] as num).toDouble(),
    isShadow: json['IsShadow'] as bool,
    baseExternalID: json['BaseExternalID'] as int,
  );
}

Map<String, dynamic> _$RestaurantDigestDataToJson(
        RestaurantDigestData instance) =>
    <String, dynamic>{
      'ClosedDate': instance.closedDate.toIso8601String(),
      'GuestsCount': instance.guestsCount,
      'BillsCount': instance.billsCount,
      'BillTotal': instance.billTotal,
      'GuestTotal': instance.guestTotal,
      'Proceeds': instance.proceeds,
      'IsShadow': instance.isShadow,
      'BaseExternalID': instance.baseExternalID,
    };
