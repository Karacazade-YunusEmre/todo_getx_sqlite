import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/consts/tables.dart';

class RepositoryHelper {
  static const databaseVersion = 1;
  static const dbName = 'repository.db';
  Database? database;

  Future<Database?> getRepository() async {
    database ??= await openRepository();

    return database;
  }

  Future<Database?> openRepository() async {
    final databasePath = await getRepositoryPath();
    final path = join(databasePath, dbName);

    try {
      await createRepositoryFile(path);

      final repository = await openDatabase(
        path,
        version: databaseVersion,
        onCreate: onCreate,
        singleInstance: true,
      );
      return repository;
    } on Exception catch (exception, stackTrace) {
      if (kDebugMode) {
        print('An Repository exception occurred: ${exception.toString()}, Stacktrace: ${stackTrace.toString()}');
      }

      return null;
    }
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(Tables.dutyTableCreateCommand);
    await db.execute(Tables.dutyTypeTableCreateCommand);
  }

  Future<void> closeRepository({required deleteOption}) async {
    Database? db = await getRepository();

    if (db != null) {
      await db.close();
    }
  }

  Future<void> onConfigure(Database db) async {}

  Future<String> getRepositoryPath() {
    final databasesPath = getDatabasesPath();

    return databasesPath;
  }

  Future<void> createRepositoryFile(String path) async {
    /// Make sure the directory exists
    final databaseFile = File(path);

    if (!databaseFile.existsSync()) {
      await File(path).create(recursive: true);
    }
  }
}
