import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:servio/constants/api_constants.dart';
import 'package:servio/utils/color.dart';

part 'data_source.g.dart';

@JsonSerializable()
class DataSource {
  @JsonKey(name: kId)
  final int id;
  @JsonKey(name: kName)
  final String name;

  final bool? isActive;

  @JsonKey(name: kColor)
  final String serverColor;

  final Color color;

  @JsonKey(name: kType)
  final int type;
  DataSource({
    required this.id,
    required this.name,
    required this.type,
    required this.serverColor,
    this.isActive = true,
  }) : this.color = HexColor.fromHex(serverColor);

  factory DataSource.fromJson(Map<String, dynamic> json) => _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);
}
