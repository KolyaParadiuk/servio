// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSource _$DataSourceFromJson(Map<String, dynamic> json) {
  return DataSource(
    id: json['ID'] as int,
    name: json['Name'] as String,
    type: json['Type'] as int,
    isActive: json['isActive'] as bool?,
  );
}

Map<String, dynamic> _$DataSourceToJson(DataSource instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'isActive': instance.isActive,
      'Type': instance.type,
    };
