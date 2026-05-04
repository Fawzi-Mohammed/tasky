import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_app/features/add_tasks/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final addTaskController = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Form(
                key: addTaskController.addNewTaskFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              title: 'Task Name',
                              controller: addTaskController.taskNameController,
                              hintText: 'Finish UI design for login screen',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a task name';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),

                            CustomTextFormField(
                              title: 'Task Description',
                              hintText:
                                  'Finish onboarding UI and hand off to devs by Thursday.',
                              controller:
                                  addTaskController.taskDescriptionController,
                              maxLines: 5,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'High Priority',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Selector<AddTaskController, bool>(
                                  selector: (context, controller) =>
                                      controller.isHighPriority,
                                  builder: (context, isHighPriority, child) {
                                    return Switch(
                                      value: isHighPriority,
                                      onChanged: (value) {
                                        addTaskController.toggle(value);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //       Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          addTaskController.addTask(context);
                        },
                        label: Text('Add Task'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
