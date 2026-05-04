import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';

class TodoTasksScreen extends StatelessWidget {
  const TodoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

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
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF15B86C),
                      ),
                    )
                  : Consumer<TasksController>(
                      builder:
                          (context, TasksController valueController, child) {
                            return TaskListWidget(
                              onEdit: controller.init,
                              onDelete: controller.deleteTask,
                              tasks: valueController.todoTasks,
                              emptyMessage: 'No To Do Tasks Yet',
                              onTap: (value, index) => controller.doneTasks(
                                value,
                                valueController.todoTasks[index!].id,
                              ),
                            );
                          },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
