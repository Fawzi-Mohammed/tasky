import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/enums/task_item_actions_enum.dart';
import 'package:tasky_app/core/services/file_storage_manger.dart';
//import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/core/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });
  final TaskModel model;
  final Function(bool? value) onChanged;
  final Function(int id) onDelete;
  final void Function() onEdit;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      alignment: Alignment.center,
      height: AppSizes.h56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.r20),
        border: isDark
            ? null
            : Border.all(
                width: AppSizes.w1,
                color: theme.dividerTheme.color ?? theme.colorScheme.tertiary,
              ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCheckBox(
            value: model.isDone,

            onChanged: (value) => onChanged(value),
          ),
          SizedBox(width: AppSizes.w16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: model.isDone
                  ? theme.textTheme.titleLarge?.color
                  : theme.colorScheme.secondary,
              size: AppSizes.w24,
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
                  break;
                case TaskItemActionsEnum.delete:
                  await _showDeleteDialog(context);

                  //  onDelete(model.id);
                  break;
                case TaskItemActionsEnum.edit:
                  final result = await _showBottomSheet(context, model);
                  if (result != null && result) {
                    onEdit();
                  }
                  break;
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values
                .map(
                  (e) => PopupMenuItem<TaskItemActionsEnum>(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showBottomSheet(BuildContext context, TaskModel model) async {
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
      // isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.pw16,
                vertical: AppSizes.ph8,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.ph30),
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

                            SizedBox(height: AppSizes.ph20),

                            CustomTextFormField(
                              title: 'Task Description',
                              hintText:
                                  'Finish onboarding UI and hand off to devs by Thursday.',
                              controller: taskDescriptionController,
                              maxLines: 5,
                            ),
                            SizedBox(height: AppSizes.ph20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'High Priority',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            List<dynamic> listTasks = await FileStorageManger()
                                .loadTasks();
                            //       final tasksJson = PreferenceManger().getString(
                            //         StorageKey.tasks,
                            //       );
                            //       List<dynamic> listTasks = [];

                            //       if (tasksJson != null) {
                            //         listTasks = jsonDecode(tasksJson);
                            //       }

                            TaskModel newModel = TaskModel(
                              id: model.id,
                              taskName: taskNameController.text,
                              taskDescription: taskDescriptionController.text,
                              isHighPriority: isHighPriority,
                              isDone: model.isDone,
                            );

                            final item = listTasks.firstWhere(
                              (e) => e['id'] == model.id,
                            );

                            final int index = listTasks.indexOf(item);
                            listTasks[index] = newModel.toJson();

                            // final taskEncode = jsonEncode(listTasks);
                            // await PreferenceManger().setString(
                            //   StorageKey.tasks,
                            //   taskEncode,
                            // );
                            await FileStorageManger().saveTasks(listTasks);

                            if (!context.mounted) return;
                            Navigator.of(context).pop(true);
                          }
                        },
                        label: Text('Edit Task'),
                      ),
                    ),
                    SizedBox(height: AppSizes.h50),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
