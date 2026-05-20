import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

    return Scaffold(
      appBar: AppBar(title: const Text('High Priority Tasks')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pw16,
          vertical: AppSizes.ph16,
        ),
        child: controller.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : Consumer<TasksController>(
                builder: (context, TasksController valueController, child) {
                  return TaskListWidget(
                    onEdit: controller.init,
                    onDelete: controller.deleteTask,
                    tasks: valueController.highPriorityTasks,
                    emptyMessage: 'No High Priority Tasks Yet',
                    onTap: (isDone, index) {
                      controller.doneTasks(
                        isDone,
                        valueController.highPriorityTasks[index!].id,
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
