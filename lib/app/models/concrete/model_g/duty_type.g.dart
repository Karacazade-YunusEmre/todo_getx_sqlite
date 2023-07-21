// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../duty_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyType _$DutyTypeFromJson(Map<String, dynamic> json) => DutyType(
      name: json['name'] as String,
    )..id = json['id'] as int?;

Map<String, dynamic> _$DutyTypeToJson(DutyType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
