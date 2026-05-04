import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_item_widget.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (context, TasksController controller, child) {
        final tasks = controller.tasks;
        return controller.isLoading
            ? SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF15B86C)),
                ),
              )
            : tasks.isEmpty
            ? SliverFillRemaining(
                hasScrollBody: false,

                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'No Tasks Yet add some !',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              )
            : SliverPadding(
                padding: EdgeInsetsGeometry.only(bottom: 80),
                sliver: SliverList.separated(
                  itemCount: tasks.length,
                  separatorBuilder: (_, _) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return TaskItemWidget(
                      onEdit: () {
                        controller.init();
                      },
                      onDelete: (id) {
                        controller.deleteTask(id);
                      },
                      model: task,
                      onChanged: (value) =>
                          controller.doneTasks(value, task.id),
                    );
                  },
                ),
              );
      },
    );
  }
}
