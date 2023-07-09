import 'package:json_annotation/json_annotation.dart';

import '../abstract/i_duty_type.dart';

part 'model_g/duty_type.g.dart';

@JsonSerializable()
class DutyType implements IDutyType {
  int? id;
  String name;

  /// for write to the database
  DutyType({required this.name});

  /// for read from the database
  DutyType.read({required this.id, required this.name});

  factory DutyType.fromJson(Map<String, dynamic> json) => _$DutyTypeFromJson(json);

  Map<String, dynamic> toJson() => _$DutyTypeToJson(this);
}
