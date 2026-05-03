import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/core/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> addNewTaskFormKey = GlobalKey<FormState>();

  bool isHighPriority = true;

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Form(
            key: addNewTaskFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          title: 'Task Name',
                          controller: taskNameController,
                          hintText: 'Finish UI design for login screen',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a task name';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        CustomTextFormField(
                          title: 'Task Description',
                          hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                          controller: taskDescriptionController,
                          maxLines: 5,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'High Priority',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Switch(
                              value: isHighPriority,
                              onChanged: (value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //       Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      if (addNewTaskFormKey.currentState?.validate() ?? false) {
                        final tasksJson = PreferenceManger().getString(
                          StorageKey.tasks,
                        );
                        List<Map<String, dynamic>> listTasks = [];

                        if (tasksJson != null) {
                          final List<dynamic> decodedTasks = jsonDecode(
                            tasksJson,
                          );
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
                        await PreferenceManger().setString(
                          StorageKey.tasks,
                          taskEncode,
                        );

                        if (!context.mounted) return;
                        Navigator.pop(context, true);
                      }
                    },
                    label: Text('Add Task'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
