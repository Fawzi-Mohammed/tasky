import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModel> completedTasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Completed Tasks',
            style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 20),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xFF15B86C)),
                  )
                : TaskListWidget(
                    onEdit: () => _loadTasks(),
                    onDelete: (id) => _deleteTask(id),
                    tasks: completedTasks,
                    onTap: (bool? isDone, int? index) async {
                      setState(() {
                        completedTasks[index!].isDone = isDone ?? false;
                      });

                      final allData = PreferenceManger().getString(
                        StorageKey.tasks,
                      );
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((taskMap) => TaskModel.fromJson(taskMap))
                                .toList();
                        final int newIndex = allDataList.indexWhere(
                          (t) => t.id == completedTasks[index!].id,
                        );

                        allDataList[newIndex] = completedTasks[index!];
                        await PreferenceManger().setString(
                          StorageKey.tasks,
                          jsonEncode(allDataList),
                        );
                        _loadTasks();
                      }
                    },
                    emptyMessage: 'No Completed Tasks Yet',
                  ),
          ),
        ),
      ],
    );
  }

  void _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    if (!mounted) return;
    final finalTask = PreferenceManger().getString(StorageKey.tasks);

    if (finalTask == null) {
      setState(() {
        completedTasks = [];
        isLoading = false;
      });
      return;
    }

    final List<dynamic> decodedTasks = jsonDecode(finalTask);

    setState(() {
      completedTasks = decodedTasks
          .map((taskMap) => TaskModel.fromJson(taskMap as Map<String, dynamic>))
          .where((e) => e.isDone)
          .toList();
      isLoading = false;
    });
  }

  Future<void> _deleteTask(int? id) async {
    if (id == null) return;
    final finalTask = PreferenceManger().getString(StorageKey.tasks);
    if (finalTask == null) {
      setState(() {
        completedTasks = [];
        isLoading = false;
      });
      return;
    }

    final List<dynamic> decodedTasks = jsonDecode(finalTask);
    final List<TaskModel> tasks = decodedTasks
        .map((e) => TaskModel.fromJson(e))
        .toList();
    tasks.removeWhere((task) => task.id == id);
    final updatedTasks = tasks.map((task) => task.toJson()).toList();
    await PreferenceManger().setString(
      StorageKey.tasks,
      jsonEncode(updatedTasks),
    );
    _loadTasks();
  }
}
