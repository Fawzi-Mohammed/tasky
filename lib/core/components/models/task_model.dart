class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  final int id;
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
