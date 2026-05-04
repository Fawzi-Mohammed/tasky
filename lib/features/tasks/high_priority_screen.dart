import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

    return Scaffold(
      appBar: AppBar(title: const Text('High Priority Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF15B86C)),
              )
            : Consumer<TasksController>(
                builder: (context,TasksController valueController, child) {
                  return TaskListWidget(
                    onEdit: controller.init,
                    onDelete: controller.deleteTask,
                    tasks: valueController.highPriorityTasks,
                    emptyMessage: 'No High Priority Tasks Yet',
                    onTap: (isDone, index) {
                      controller.doneTasks(
                        isDone,
                        valueController .highPriorityTasks[index!].id,
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
