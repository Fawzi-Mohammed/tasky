import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/core/services/preference_manger.dart';

class HomeController with ChangeNotifier {
  String? userName = 'Guest';
  List<TaskModel> task = [];
  bool isLoading = true;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percentage = 0;
  String? userImagePath;
  List<TaskModel> tasks = [];
  void init() {
    loadUserData();
    loadTasks();
  }

  void loadUserData() async {
    userName = PreferenceManger().getString(StorageKey.userName);
    userImagePath = PreferenceManger().getString(StorageKey.userImage);
    notifyListeners();
  }

  void loadTasks() async {
    isLoading = true;
    final finalTask = PreferenceManger().getString(StorageKey.tasks);

    if (finalTask == null) {
      task = [];
      isLoading = false;

      return;
    }

    final List<dynamic> decodedTasks = jsonDecode(finalTask);

    task = decodedTasks
        .map((taskMap) => TaskModel.fromJson(taskMap as Map<String, dynamic>))
        .toList();
    calculatePercentage();
    isLoading = false;
    notifyListeners();
  }

  void calculatePercentage() {
    totalTasks = task.length;
    totalDoneTasks = task.where((task) => task.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }

  Future<void> deleteTask(int? id) async {
    if (id == null) return;

    task.removeWhere((task) => task.id == id);
    calculatePercentage();

    final updatedTasks = task.map((task) => task.toJson()).toList();
    await PreferenceManger().setString(
      StorageKey.tasks,
      jsonEncode(updatedTasks),
    );
    notifyListeners();
  }

  Future<void> doneTask(int? index, bool? isDone) async {
    task[index!].isDone = isDone ?? false;
    calculatePercentage();

    final updatedTasks = task.map((task) => task.toJson()).toList();
    await PreferenceManger().setString(
      StorageKey.tasks,
      jsonEncode(updatedTasks),
    );
    notifyListeners();
  }
}
