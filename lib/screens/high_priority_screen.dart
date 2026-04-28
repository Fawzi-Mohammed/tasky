import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/widgets/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFF15B86C)))
            : TaskListWidget(
                onEdit: () => _loadTasks(),
                onDelete: (id) => _deleteTask(id),
                tasks: highPriorityTasks,
                emptyMessage: 'No To Do Tasks Yet',
                onTap: (bool? isDone, int? index) async {
                  setState(() {
                    highPriorityTasks[index!].isDone = isDone ?? false;
                  });

                  final allData = PreferenceManger().getString('tasks');
                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((taskMap) => TaskModel.fromJson(taskMap))
                        .toList();
                    final int newIndex = allDataList.indexWhere(
                      (t) => t.id == highPriorityTasks[index!].id,
                    );

                    allDataList[newIndex] = highPriorityTasks[index!];
                    await PreferenceManger().setString(
                      'tasks',
                      jsonEncode(allDataList),
                    );
                    _loadTasks();
                  }
                },
              ),
      ),
    );
  }

  void _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    if (!mounted) return;
    final finalTask = PreferenceManger().getString('tasks');

    if (finalTask == null) {
      setState(() {
        highPriorityTasks = [];
        isLoading = false;
      });
      return;
    }

    final List<dynamic> decodedTasks = jsonDecode(finalTask);

    setState(() {
      highPriorityTasks = decodedTasks
          .map((taskMap) => TaskModel.fromJson(taskMap as Map<String, dynamic>))
          .where((task) => task.isHighPriority)
          .toList();
      highPriorityTasks = highPriorityTasks.reversed.toList();
      isLoading = false;
    });
  }

  Future<void> _deleteTask(int? id) async {
    if (id == null) return;
    final finalTask = PreferenceManger().getString('tasks');
    if (finalTask == null) {
      setState(() {
        highPriorityTasks = [];
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
    await PreferenceManger().setString('tasks', jsonEncode(updatedTasks));
    _loadTasks();
  }
}
