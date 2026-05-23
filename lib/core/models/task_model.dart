import 'package:hive_ce_flutter/hive_flutter.dart';
 part 'task_model.g.dart';
@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String taskName;
  @HiveField(1)
  final String taskDescription;
  @HiveField(2)
  final bool isHighPriority;
  @HiveField(3)
  final int id;
  @HiveField(4)
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      taskName: json['taskName'] as String,
      taskDescription: json['taskDescription'] as String,
      isHighPriority: json['isHighPriority'] as bool,
      isDone: json['isDone'] as bool? ?? false,
    );
  }
}
