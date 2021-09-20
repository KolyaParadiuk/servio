import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:servio/constants/api_constants.dart';

part 'data_source.g.dart';

@JsonSerializable()
class DataSource {
  @JsonKey(name: kId)
  final int id;
  @JsonKey(name: kName)
  final String name;

  final bool? isActive;

  final Color color;

  @JsonKey(name: kType)
  final int type;
  DataSource({
    required this.id,
    required this.name,
    required this.type,
    this.isActive = true,
  }) : this.color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  factory DataSource.fromJson(Map<String, dynamic> json) => _$DataSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceToJson(this);
}
