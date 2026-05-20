import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/constants/app_sizes.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture.dart';
import 'package:tasky_app/features/add_tasks/add_task_screen.dart';
import 'package:tasky_app/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky_app/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky_app/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky_app/features/home/controllers/home_controller.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController()..init(),

      child: Scaffold(
        floatingActionButton: Builder(
          builder: (BuildContext controllerContext) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const AddTaskScreen();
                    },
                  ),
                );

                if (result != null && result) {
                  controllerContext.read<TasksController>().init();
                }
              },

              label: Text('Add New Task'),
              icon: Icon(Icons.add),
            );
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pw16,
            vertical: AppSizes.ph16,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Selector<HomeController, String?>(
                          selector: (context, HomeController controller) =>
                              controller.userImagePath,
                          builder: (context, String? userImagePath, child) {
                            return CircleAvatar(
                              radius: AppSizes.w21,
                              backgroundImage: userImagePath == null
                                  ? AssetImage('assets/images/avtare.png')
                                  : FileImage(File(userImagePath)),
                              backgroundColor: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(width: AppSizes.w8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector<HomeController, String?>(
                              selector: (context, HomeController controller) =>
                                  controller.userName,
                              builder: (context, String? userName, child) {
                                return Text(
                                  'Good Evening ,$userName',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                );
                              },
                            ),
                            Text(
                              'One task at a time.One step closer.',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
                    Text(
                      'Yuhuu ,Your work Is',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),

                    Row(
                      children: [
                        Text(
                          'almost done ! ',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        CustomSvgPicture.withColorFilter(
                          path: 'assets/images/waving-hand.svg',
                          size: 32,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
                    AchievedTasksWidget(),
                    SizedBox(height: AppSizes.h8),
                    HighPriorityTasksWidget(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSizes.ph24,
                        bottom: AppSizes.ph16,
                      ),
                      child: Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),

              SliverTaskListWidget(),
              //
            ],
          ),
        ),
      ),
    );
  }
}
