import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<TasksController>(
      builder: (context, TasksController controller, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pw16,
            vertical: AppSizes.ph16,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.r20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'Achieved Tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppSizes.ph4),
                  Text(
                    '${controller.totalDoneTasks} Out of ${controller.totalTasks} Done',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: AppSizes.w48,
                    height: AppSizes.h48,
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: CircularProgressIndicator(
                        value: controller.percentage,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.primary,
                        ),
                        backgroundColor: theme.colorScheme.tertiary,
                        strokeWidth: AppSizes.w4,
                      ),
                    ),
                  ),
                  Text(
                    '${(controller.percentage * 100).toInt()}%',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
