import 'package:flutter/material.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/core/services/hive_storage_manager.dart';

class TasksController extends ChangeNotifier {
  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percentage = 0;
  bool isLoading = false;

  void init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;

    tasks = HiveStorageManager().loadTasks();
    _loadData();
    _calculatePercentage();
    isLoading = false;
    notifyListeners();
  }

  Future<void> doneTasks(bool? value, int id) async {
    final int index = tasks.indexWhere((task) => task.id == id);
    if (index == -1) return;

    tasks[index].isDone = value ?? false;
    await HiveStorageManager().saveTasks(tasks);
    _loadData();
    _calculatePercentage();
    notifyListeners();
  }

  void _loadData() {
    todoTasks = tasks.where((task) => !task.isDone).toList();
    completedTasks = tasks.where((task) => task.isDone).toList();
    highPriorityTasks = tasks
        .where((task) => task.isHighPriority)
        .toList()
        .reversed
        .toList();
  }

  Future<void> deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((task) => task.id == id);
    await HiveStorageManager().saveTasks(tasks);
    _loadData();
    _calculatePercentage();
    notifyListeners();
  }

  void _calculatePercentage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((task) => task.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  void clearTasks() {
    _loadTasks();
  }
}
