import 'package:json_annotation/json_annotation.dart';
import 'package:servio/constants/api_constants.dart';

part 'authentication_response.g.dart';

@JsonSerializable()
class AuthenticationResponse {
  @JsonKey(name: kAccessToken)
  final String token;
  @JsonKey(name: kTokenType)
  final String tokenType;
  AuthenticationResponse({required this.token, required this.tokenType});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
