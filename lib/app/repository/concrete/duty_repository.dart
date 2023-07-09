import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/result/abstract/i_data_result.dart';
import '../../core/result/abstract/i_result.dart';
import '../../core/result/concrete/error_data_result.dart';
import '../../core/result/concrete/error_result.dart';
import '../../core/result/concrete/success_data_result.dart';
import '../../core/result/concrete/success_result.dart';
import '../../data/consts/tables.dart';
import '../../model/concrete/duty.dart';
import '../abstract/i_duty_repository.dart';
import 'helper/repository_helper.dart';

class DutyRepository implements IDutyRepository {
  final tableName = Tables.dutyTableName;
  final columns = Tables.dutyColumnNames;
  final tableId = Tables.dutyColumnNames[0];
  late RepositoryHelper helper;

  DutyRepository() {
    helper = Get.find();
  }

  @override
  Future<IDataResult<Duty>> add(Duty item) async {
    try {
      Database? db = await helper.getRepository();

      if (db == null) {
        return ErrorDataResult<Duty>();
      }

      final id = await db.insert(tableName, item.toJson());

      if (id == 0) {
        return ErrorDataResult<Duty>();
      }

      item.id = id;
      return SuccessDataResult<Duty>(data: item);
    } on Exception catch (exception, stackTrace) {
      if (kDebugMode) {
        print('An exception occurred in DutyRepository on Add Model. Exception: ${exception.toString()}, StackTrace: ${stackTrace.toString()}');
      }

      return ErrorDataResult<Duty>();
    }
  }

  @override
  Future<IResult> delete(Duty item) async {
    try {
      Database? db = await helper.getRepository();

      if (db == null) {
        return ErrorResult();
      }

      final id = await db.delete(
        tableName,
        where: '$tableId = ?',
        whereArgs: [item.id],
      );

      if (id == 0) {
        return ErrorResult();
      }
      return SuccessResult();
    } on Exception catch (exception, stackTrace) {
      if (kDebugMode) {
        print('An exception occurred in DutyRepository on Delete Model. Exception: ${exception.toString()}, StackTrace: ${stackTrace.toString()}');
      }

      return ErrorResult();
    }
  }

  @override
  Future<IDataResult<List<Duty>?>> getAll() async {
    try {
      Database? db = await helper.getRepository();

      if (db == null) {
        return ErrorDataResult<List<Duty>?>();
      }

      List<Map<String, Object?>> maps = await db.query(
        tableName,
        columns: columns,
      );

      if (maps.isEmpty) {
        return ErrorDataResult<List<Duty>?>();
      }

      List<Duty> dutyList = List.generate(maps.length, (int index) {
        return Duty.fromJson(maps[index]);
      }).toList();

      return SuccessDataResult<List<Duty>?>(data: dutyList);
    } on Exception catch (exception, stackTrace) {
      if (kDebugMode) {
        print('An exception occurred in DutyRepository on GetAll. Exception: ${exception.toString()}, StackTrace: ${stackTrace.toString()}');
      }

      return ErrorDataResult<List<Duty>?>();
    }
  }

  @override
  Future<IResult> update(Duty item) async {
    try {
      Database? db = await helper.getRepository();

      if (db == null) {
        return ErrorResult();
      }

      final id = await db.update(
        tableName,
        item.toJson(),
        where: '$tableId=?',
        whereArgs: [item.id],
      );

      if (id == 0) {
        return ErrorResult();
      }

      return SuccessResult();
    } on Exception catch (exception, stackTrace) {
      if (kDebugMode) {
        print('An exception occurred in DutyRepository on Update Model. Exception: ${exception.toString()}, StackTrace: ${stackTrace.toString()}');
      }

      return ErrorResult();
    }
  }
}
