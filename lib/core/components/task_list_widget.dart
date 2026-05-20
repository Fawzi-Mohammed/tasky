import 'package:flutter/material.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/core/components/task_item_widget.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final void Function(bool? isDone, int? index) onTap;
  final String emptyMessage;
  final Function(int id) onDelete;
  final void Function() onEdit;
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSizes.r20),
            ),
            alignment: Alignment.center,
            child: Text(
              emptyMessage,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        : ListView.separated(
            itemCount: tasks.length,
            padding: EdgeInsets.only(bottom: AppSizes.ph60),
            separatorBuilder: (_, _) => SizedBox(height: AppSizes.h8),
            itemBuilder: (context, index) {
              final task = tasks[index];

              return TaskItemWidget(
                onDelete: (id) => onDelete(id),
                onEdit: () => onEdit(),
                model: task,
                onChanged: (value) => onTap(value, index),
              );
            },
          );
  }
}
