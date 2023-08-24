import 'dart:io';

import 'package:path_provider/path_provider.dart';

mixin UtilitiesMixin {
  Future<String> getApplicationTemporaryDirectoryPath() async {
    final filePath = await getTemporaryDirectory();
    return filePath.path;
  }

  Future<String> getExternalStorageDirectoryPath() async {
    if (Platform.isAndroid) {
      final externalStorageDirectory = await getExternalStorageDirectory();

      return externalStorageDirectory!.path;
    } else {
      final externalStorageDirectory = await getApplicationSupportDirectory();

      return externalStorageDirectory.path;
    }
  }

  Future<String> getSupportDirectoryPath() async {
    final databasePath = await getApplicationSupportDirectory();
    return databasePath.path;
  }

  Future<String?> getDocumentDirectoryPath() async {
    final filePath = await getApplicationDocumentsDirectory();
    return filePath.path;
  }

  Future<void> deleteExistsFile(
      {required String filePath, bool? recursive}) async {
    File existsFile = File(filePath);

    if (existsFile.existsSync()) {
      await existsFile.delete(recursive: recursive ?? true);
    }
  }

  Future<void> createAppDirectory(
      {required String directoryPath, bool? recursive}) async {
    Directory directory = Directory(directoryPath);

    if (!directory.existsSync()) {
      await directory.create(recursive: recursive ?? false);
    }
  }

  bool saveByteFile({required List<int> fileBytes, required String filePath}) {
    try {
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
