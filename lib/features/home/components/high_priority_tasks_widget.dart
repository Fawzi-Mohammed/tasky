import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky_app/features/tasks/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<TasksController>(
      builder: (context, controller, child) {
        final highPriorityTasks = controller.highPriorityTasks;
        final itemCount = highPriorityTasks.length > 4
            ? 4
            : highPriorityTasks.length;

        return highPriorityTasks.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppSizes.r20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.pw16,
                              vertical: AppSizes.ph16,
                            ),
                            child: Text(
                              'High Priority Tasks',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              final task = highPriorityTasks[index];
                              return Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.r20,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomCheckBox(
                                      value: task.isDone,
                                      onChanged: (value) {
                                        controller.doneTasks(value, task.id);
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        task.taskName,
                                        style: task.isDone
                                            ? Theme.of(
                                                context,
                                              ).textTheme.titleLarge
                                            : Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HighPriorityScreen(),
                          ),
                        );
                        controller.init();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.pw16,
                          vertical: AppSizes.ph16,
                        ),
                        child: Container(
                          height: AppSizes.h56,
                          width: AppSizes.w48,
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.pw8,
                            vertical: AppSizes.ph8,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  theme.dividerTheme.color ??
                                  theme.colorScheme.tertiary,
                              width: AppSizes.w2,
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/arrow_up_right.svg',
                            width: AppSizes.w24,
                            height: AppSizes.h24,
                            colorFilter: ColorFilter.mode(
                              theme.colorScheme.secondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
