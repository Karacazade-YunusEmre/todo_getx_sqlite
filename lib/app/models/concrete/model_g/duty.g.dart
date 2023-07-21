// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../duty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Duty _$DutyFromJson(Map<String, dynamic> json) => Duty(
      title: json['title'] as String,
      done: json['done'] == 1 ? true : false,
      typeId: json['type_id'],
    )..id = json['id'] as int?;

Map<String, dynamic> _$DutyToJson(Duty instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'done': instance.done == true ? 1 : 0,
      'type_id': instance.typeId,
    };
