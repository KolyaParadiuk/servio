import 'package:json_annotation/json_annotation.dart';
import 'package:servio/constants/api_constants.dart';

part 'data_source.g.dart';

@JsonSerializable()
class DataSource {
  @JsonKey(name: kId)
  final int id;
  @JsonKey(name: kName)
  final String name;

  @JsonKey(name: kType)
  final String type;
  DataSource({
    required this.id,
    required this.name,
    required this.type,
  });

  factory DataSource.fromJson(Map<String, dynamic> json) => _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);
}
