import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> todoTasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'To Do Tasks',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF15B86C),
                      ),
                    )
                  : TaskListWidget(
                      onEdit: () => _loadTasks(),
                      onDelete: (id) => _deleteTask(id),
                      tasks: todoTasks,
                      emptyMessage: 'No To Do Tasks Yet',
                      onTap: (bool? isDone, int? index) async {
                        setState(() {
                          todoTasks[index!].isDone = isDone ?? false;
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
                            (t) => t.id == todoTasks[index!].id,
                          );

                          allDataList[newIndex] = todoTasks[index!];
                          await PreferenceManger().setString(
                            StorageKey.tasks,
                            jsonEncode(allDataList),
                          );
                          _loadTasks();
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
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
        todoTasks = [];
        isLoading = false;
      });
      return;
    }

    final List<dynamic> decodedTasks = jsonDecode(finalTask);

    setState(() {
      todoTasks = decodedTasks
          .map((taskMap) => TaskModel.fromJson(taskMap as Map<String, dynamic>))
          .where((task) => task.isDone == false)
          .toList();
      isLoading = false;
    });
  }

  Future<void> _deleteTask(int? id) async {
    if (id == null) return;
    final finalTask = PreferenceManger().getString(StorageKey.tasks);
    if (finalTask == null) {
      setState(() {
        todoTasks = [];
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
