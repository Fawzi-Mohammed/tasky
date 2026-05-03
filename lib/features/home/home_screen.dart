import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture.dart';
import 'package:tasky_app/core/models/task_model.dart';
import 'package:tasky_app/features/add_tasks/add_task_screen.dart';
import 'package:tasky_app/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky_app/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky_app/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  List<TaskModel> task = [];
  bool isLoading = true;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percentage = 0;
  String? userImagePath;

  @override
  void initState() {
    super.initState();

    _loadUserName();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
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
              _loadTasks();
            }
          },

          label: Text('Add New Task'),
          icon: Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 21,
                        backgroundImage: userImagePath == null
                            ? AssetImage('assets/images/avtare.png')
                            : FileImage(File(userImagePath!)),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Evening ,$userName',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'One task at a time.One step closer.',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  AchievedTasksWidget(
                    totalDoneTasks: totalDoneTasks,
                    totalTasks: totalTasks,
                    percentage: percentage,
                  ),
                  SizedBox(height: 8),
                  task.isNotEmpty
                      ? HighPriorityTasksWidget(
                          tasks: task,
                          onTap: (isDone, index) {
                            _doneTask(index, isDone);
                          },
                          refresh: _loadTasks,
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                    child: Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF15B86C),
                      ),
                    ),
                  )
                : SliverTaskListWidget(
                    onEdit: () => _loadTasks(),
                    onDelete: (id) => _deleteTask(id),
                    tasks: task,
                    onTap: (isDone, index) {
                      _doneTask(index, isDone);
                    },
                    emptyMessage: 'No Tasks Yet add some !',
                  ),
            //
          ],
          //    Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [

          //     Expanded(
          //       child: isLoading
          //           ?
          //           : TaskListWidget(
          //               tasks: task,
          //               onTap: (bool? isDone, int? index) {
          //                 _doneTask(index, isDone);
          //               },
          //               emptyMessage: 'No Tasks Yet add some !',
          //             ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  Future<void> _doneTask(int? index, bool? isDone) async {
    setState(() {
      task[index!].isDone = isDone ?? false;
      _calculatePercentage();
    });
    final updatedTasks = task.map((task) => task.toJson()).toList();
    await PreferenceManger().setString(StorageKey.tasks, jsonEncode(updatedTasks));
  }

  void _loadUserName() async {
    if (!mounted) return;
    setState(() {
      userName = PreferenceManger().getString(StorageKey.userName);
      userImagePath = PreferenceManger().getString(StorageKey.userImage);
    });
  }

  void _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    if (!mounted) return;
    final finalTask = PreferenceManger().getString(StorageKey.tasks);

    if (finalTask == null) {
      setState(() {
        task = [];
        isLoading = false;
      });
      return;
    }

    final List<dynamic> decodedTasks = jsonDecode(finalTask);

    setState(() {
      task = decodedTasks
          .map((taskMap) => TaskModel.fromJson(taskMap as Map<String, dynamic>))
          .toList();
      _calculatePercentage();
    });
    setState(() {
      isLoading = false;
    });
  }

  void _calculatePercentage() {
    totalTasks = task.length;
    totalDoneTasks = task.where((task) => task.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  Future<void> _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      task.removeWhere((task) => task.id == id);
      _calculatePercentage();
    });
    final updatedTasks = task.map((task) => task.toJson()).toList();
    await PreferenceManger().setString(StorageKey.tasks, jsonEncode(updatedTasks));
  }
}
