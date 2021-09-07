import 'package:json_annotation/json_annotation.dart';
import 'package:servio/constants/api_constants.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  @JsonKey(name: kId)
  final int id;
  @JsonKey(name: kParentId)
  final int? parentId;
  @JsonKey(name: kIsReport)
  final bool isReport;
  @JsonKey(name: kName)
  final String name;
  @JsonKey(name: kDescription)
  final String description;
  Report({
    required this.description,
    required this.id,
    required this.isReport,
    required this.name,
    required this.parentId,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
