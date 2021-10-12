import 'package:servio/constants/api_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mobile_settings.g.dart';

@JsonSerializable()
class MobildSettings {
  @JsonKey(name: kVersion)
  final int version;

  MobildSettings({required this.version});
  factory MobildSettings.fromJson(Map<String, dynamic> json) => _$MobildSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$MobildSettingsToJson(this);
}
