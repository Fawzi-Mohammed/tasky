import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pw18,
            vertical: AppSizes.h18,
          ),
          child: Text(
            'Completed Tasks',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
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
                        tasks: valueController.completedTasks,
                        onTap: (isDone, index) {
                          controller.doneTasks(
                            isDone,
                            valueController.completedTasks[index!].id,
                          );
                        },
                        emptyMessage: 'No Completed Tasks Yet',
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
