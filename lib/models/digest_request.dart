import 'package:json_annotation/json_annotation.dart';
import 'package:servio/constants/api_constants.dart';
import 'package:servio/models/data_source.dart';

part 'digest_request.g.dart';

// {
//   "From": "2021-09-18T12:26:17.188Z",
//   "To": "2021-09-18T12:26:17.188Z",
//   "Sources": [
//     {
//       "ID": 0,
//       "Type": 0
//     }
//   ]
// }
@JsonSerializable(explicitToJson: true)
class DigestRequest {
  @JsonKey(name: kFrom)
  final String from;

  @JsonKey(name: kTo)
  final String to;

  @JsonKey(name: kSources)
  final List<DataSource> sources;

  DigestRequest({
    required this.from,
    required this.to,
    required this.sources,
  });

  factory DigestRequest.fromJson(Map<String, dynamic> json) => _$DigestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DigestRequestToJson(this);
}
