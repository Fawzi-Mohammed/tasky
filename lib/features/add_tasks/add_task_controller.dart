import 'package:flutter/material.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/core/services/hive_storage_manger.dart';

class AddTaskController extends ChangeNotifier {
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> addNewTaskFormKey = GlobalKey<FormState>();

  bool isHighPriority = true;
  void addTask(BuildContext context) async {
    if (addNewTaskFormKey.currentState?.validate() ?? false) {
      List<TaskModel> listTasks = HiveStorageManger().loadTasks();

      listTasks.add(
        TaskModel(
          id: listTasks.length + 1,
          taskName: taskNameController.text,
          taskDescription: taskDescriptionController.text,
          isHighPriority: isHighPriority,
        ),
      );
      await HiveStorageManger().saveTasks(listTasks);
      if (!context.mounted) return;
      Navigator.pop(context, true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
