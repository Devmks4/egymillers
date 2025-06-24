import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> _getFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName.json';
  }

  Future<File> _getFile(String fileName) async {
    final path = await _getFilePath(fileName);
    return File(path);
  }

  Future<void> writeJson(String fileName, Map<String, dynamic> data) async {
    final file = await _getFile(fileName);
    final jsonData = jsonEncode(data);
    await file.writeAsString(jsonData);
  }

  Future<Map<String, dynamic>?> readJson(String fileName) async {
    try {
      final file = await _getFile(fileName);
      final contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      // File not found or invalid JSON
      return null;
    }
  }

  Future<void> deleteFile(String fileName) async {
    final file = await _getFile(fileName);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
