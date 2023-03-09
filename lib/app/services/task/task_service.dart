import 'package:todo_list_flutter/app/models/task_model.dart';

import '../../models/week_task.dart';

abstract class TaskService {
  Future<void> saveTask(DateTime dateTime, String description);
  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTask> getWeek();
}
