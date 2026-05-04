import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/core/services/preference_manger.dart';

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

  void _loadTasks() async {
    isLoading = true;
    final finalTask = PreferenceManger().getString(StorageKey.tasks);

    if (finalTask == null) {
      tasks = [];
      isLoading = false;

      return;
    }

    final List<dynamic> decodedTasks = jsonDecode(finalTask);

    tasks = decodedTasks
        .map((taskMap) => TaskModel.fromJson(taskMap as Map<String, dynamic>))
        .toList();
    isLoading = false;
    notifyListeners();

    tasks = decodedTasks
        .map((taskMap) => TaskModel.fromJson(taskMap as Map<String, dynamic>))
        .toList();

    isLoading = false;
    _loadData();
    _calculatePercentage();
  }

  void doneTasks(bool? value, int id) async {
    final int index = tasks.indexWhere((task) => task.id == id);
    tasks[index].isDone = value ?? false;
    _calculatePercentage();
    final updateTasks = tasks.map((task) => task.toJson()).toList();
    await PreferenceManger().setString(
      StorageKey.tasks,
      jsonEncode(updateTasks),
    );
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
    _loadData();
    _calculatePercentage();
    final updatedTasks = tasks.map((task) => task.toJson()).toList();
    await PreferenceManger().setString(
      StorageKey.tasks,
      jsonEncode(updatedTasks),
    );

    notifyListeners();
  }

  void _calculatePercentage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((task) => task.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }
}
