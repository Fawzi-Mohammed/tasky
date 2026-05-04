import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';
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
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Completed Tasks',
            style: const TextStyle(color: Color(0xFFFFFCFC), fontSize: 20),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF15B86C)),
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
