// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report(
    description: json['Description'] as String,
    id: json['ID'] as int,
    isReport: json['IsReport'] as bool,
    name: json['Name'] as String,
    parentId: json['ParentID'] as int?,
  );
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'ID': instance.id,
      'ParentID': instance.parentId,
      'IsReport': instance.isReport,
      'Name': instance.name,
      'Description': instance.description,
    };
