import 'package:todo_list_flutter/app/models/task_model.dart';

abstract class TaskRepo {
  Future<void> saveTask(DateTime dateTime, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
}
