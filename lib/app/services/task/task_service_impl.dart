// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_flutter/app/models/task_model.dart';
import 'package:todo_list_flutter/app/repositories/task/task_repo.dart';
import 'package:todo_list_flutter/app/services/task/task_service.dart';

import '../../models/week_task.dart';

class TaskServiceImpl implements TaskService {
  final TaskRepo _taskRepo;

  TaskServiceImpl({
    required TaskRepo taskRepo,
  }) : _taskRepo = taskRepo;

  @override
  Future<void> saveTask(DateTime dateTime, String description) =>
      _taskRepo.saveTask(dateTime, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _taskRepo.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() async {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return _taskRepo.findByPeriod(tomorrow, tomorrow);
  }

  @override
  Future<WeekTask> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(
      today.year,
      today.month,
      today.day,
      0,
      0,
      0,
    );

    DateTime endFilter;
    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    endFilter = startFilter.add(const Duration(days: 7));

    final tasks = await _taskRepo.findByPeriod(startFilter, endFilter);
    return WeekTask(start: startFilter, end: endFilter, models: tasks);
  }
}
