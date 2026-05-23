import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tasky_app/core/constants/constants.dart';
import 'package:tasky_app/core/models/task_model.dart';

class HiveStorageManger {
  static final HiveStorageManger _instance = HiveStorageManger._();
  HiveStorageManger._();
  late Box<TaskModel> _tasksBox;

  factory HiveStorageManger() {
    return _instance;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    _tasksBox = await Hive.openBox<TaskModel>(Constants.tasksCollection);
  }

  Future<void> saveTasks(List<TaskModel> list) async {
    await _tasksBox.clear();
    await _tasksBox.addAll(list);
  }

  List<TaskModel> loadTasks() {
    return _tasksBox.values.toList();
  }

  Future<void> clear() async {
    await _tasksBox.clear();
  }
}
