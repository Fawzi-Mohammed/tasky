import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._();
  FileStorageManager._();
  late final Directory _appDirectory;
  late final File _tasksFile;
  factory FileStorageManager() {
    return _instance;
  }
  Future<void> int() async {
    _appDirectory = await getApplicationDocumentsDirectory();
    _tasksFile = File('${_appDirectory.path}/tasks.json');
  }

  Future<void> saveTasks(List<dynamic> list) async {
    final listJson = jsonEncode(list);
    await _tasksFile.writeAsString(listJson);
  }

  Future<List<dynamic>> loadTasks() async {
    if (!await _tasksFile.exists()) return [];
    final tasksJson = await _tasksFile.readAsString();
    return jsonDecode(tasksJson) as List<dynamic>;
  }

  Future<void> clear() async {
    if (!await _tasksFile.exists()) return;
    await _tasksFile.delete();
  }
}
