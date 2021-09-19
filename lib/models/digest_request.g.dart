// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digest_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigestRequest _$DigestRequestFromJson(Map<String, dynamic> json) {
  return DigestRequest(
    from: json['From'] as String,
    to: json['To'] as String,
    sources: (json['Sources'] as List<dynamic>)
        .map((e) => DataSource.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DigestRequestToJson(DigestRequest instance) =>
    <String, dynamic>{
      'From': instance.from,
      'To': instance.to,
      'Sources': instance.sources.map((e) => e.toJson()).toList(),
    };
