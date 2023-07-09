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
import '../../model/concrete/duty_type.dart';
import '../abstract/i_duty_type_repository.dart';
import 'helper/repository_helper.dart';

class DutyTypeRepository implements IDutyTypeRepository {
  final tableName = Tables.dutyTypeTableName;
  final columns = Tables.dutyTypeColumnNames;
  final tableId = Tables.dutyTypeColumnNames[0];
  late RepositoryHelper helper;

  DutyTypeRepository() {
    helper = Get.find();
  }

  @override
  Future<IDataResult<DutyType>> add(DutyType item) async {
    try {
      Database? db = await helper.getRepository();

      if (db == null) {
        return ErrorDataResult<DutyType>();
      }

      final id = await db.insert(tableName, item.toJson());

      if (id == 0) {
        return ErrorDataResult<DutyType>();
      }

      item.id = id;
      return SuccessDataResult<DutyType>(data: item);
    } on Exception catch (exception, stackTrace) {
      if (kDebugMode) {
        print('An exception occurred in DutyTypeRepository on Add Model. Exception: ${exception.toString()}, StackTrace: ${stackTrace.toString()}');
      }

      return ErrorDataResult<DutyType>();
    }
  }

  @override
  Future<IResult> delete(DutyType item) async {
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
        print('An exception occurred in DutyTypeRepository on Delete Model. Exception: ${exception.toString()}, StackTrace: ${stackTrace.toString()}');
      }

      return ErrorResult();
    }
  }

  @override
  Future<IDataResult<List<DutyType>?>> getAll() async {
    try {
      Database? db = await helper.getRepository();

      if (db == null) {
        return ErrorDataResult<List<DutyType>?>();
      }

      List<Map<String, Object?>> maps = await db.query(
        tableName,
        columns: columns,
      );

      if (maps.isEmpty) {
        return ErrorDataResult<List<DutyType>?>();
      }

      List<DutyType> dutyList = List.generate(maps.length, (int index) {
        return DutyType.fromJson(maps[index]);
      }).toList();

      return SuccessDataResult<List<DutyType>?>(data: dutyList);
    } on Exception catch (exception, stackTrace) {
      if (kDebugMode) {
        print('An exception occurred in DutyTypeRepository on GetAll. Exception: ${exception.toString()}, StackTrace: ${stackTrace.toString()}');
      }

      return ErrorDataResult<List<DutyType>?>();
    }
  }

  @override
  Future<IResult> update(DutyType item) async {
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
        print('An exception occurred in DutyTypeRepository on Update Model. Exception: ${exception.toString()}, StackTrace: ${stackTrace.toString()}');
      }

      return ErrorResult();
    }
  }
}
