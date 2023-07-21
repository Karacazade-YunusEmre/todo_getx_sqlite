import 'package:json_annotation/json_annotation.dart';

import '../abstract/i_duty.dart';

part 'model_g/duty.g.dart';

@JsonSerializable()
class Duty implements IDuty {
  int? id;
  String title;
  bool done;
  int typeId;

  Duty({
    this.id,
    required this.title,
    required this.done,
    required this.typeId,
  });

  factory Duty.fromJson(Map<String, dynamic> json) => _$DutyFromJson(json);

  Map<String, dynamic> toJson() => _$DutyToJson(this);
}
