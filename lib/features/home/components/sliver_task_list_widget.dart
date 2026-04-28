import 'package:flutter/material.dart';
import 'package:tasky_app/core/components/models/task_model.dart';
import 'package:tasky_app/core/components/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final void Function(bool? isDone, int? index) onTap;
  final void Function(int? id) onDelete;
  final void Function() onEdit;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
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
                emptyMessage,
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
                    onEdit();
                  },
                  onDelete: (id) {
                    onDelete(id);
                  },
                  model: task,
                  onChanged: (value) => onTap(value, index),
                );
              },
            ),
          );
  }
}
