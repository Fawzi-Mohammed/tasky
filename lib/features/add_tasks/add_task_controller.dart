import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/core/services/preference_manger.dart';

class AddTaskController extends ChangeNotifier {
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> addNewTaskFormKey = GlobalKey<FormState>();

  bool isHighPriority = true;
  void addTask(BuildContext context) async {
    if (addNewTaskFormKey.currentState?.validate() ?? false) {
      final tasksJson = PreferenceManger().getString(StorageKey.tasks);
      List<Map<String, dynamic>> listTasks = [];

      if (tasksJson != null) {
        final List<dynamic> decodedTasks = jsonDecode(tasksJson);
        listTasks = decodedTasks
            .map((task) => task as Map<String, dynamic>)
            .toList();
      }

      listTasks.add(
        TaskModel(
          id: listTasks.length + 1,
          taskName: taskNameController.text,
          taskDescription: taskDescriptionController.text,
          isHighPriority: isHighPriority,
        ).toJson(),
      );

      final taskEncode = jsonEncode(listTasks);
      await PreferenceManger().setString(StorageKey.tasks, taskEncode);
      Navigator.pop(context, true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
