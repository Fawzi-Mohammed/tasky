import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_check_box.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky_app/features/tasks/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  borderRadius: BorderRadius.circular(20.0),
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
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'High Priority Tasks',
                              style: TextStyle(
                                color: Color(0xFF15B86C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomCheckBox(
                                      value: task.isDone,
                                      onChanged: (value) {
                                        controller.doneTasks(
                                          value,
                                          task.id,
                                        );
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
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 56,
                          width: 48,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ThemeController.isDark
                                  ? const Color(0xFF6E6E6E)
                                  : const Color(0xFFD1DAD6),
                              width: 2,
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/arrow_up_right.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ThemeController.isDark
                                ? null
                                : const ColorFilter.mode(
                                    Color(0xFF3A4640),
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
