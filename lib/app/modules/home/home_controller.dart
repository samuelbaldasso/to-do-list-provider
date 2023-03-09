// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_list_flutter/app/models/task_fliter_enum.dart';
import 'package:todo_list_flutter/app/models/task_model.dart';
import 'package:todo_list_flutter/app/models/total_tasks.dart';
import 'package:todo_list_flutter/app/models/week_task.dart';
import 'package:todo_list_flutter/app/services/task/task_service.dart';

import '../../core/notifier/default_change_notifier.dart';

class HomeController extends DefaultChangeNotifier {
  final TaskService _taskService;
  HomeController({
    required TaskService taskService,
  }) : _taskService = taskService;

  final TaskFilterEnum selected = TaskFilterEnum.today;
  TotalTasks? todayTasks;
  TotalTasks? tomorrowTasks;
  TotalTasks? weekTasks;

  void loadAllTasks() async {
    final result = await Future.wait([
      _taskService.getToday(),
      _taskService.getTomorrow(),
      _taskService.getWeek(),
    ]);

    final today = result[0] as List<TaskModel>;
    final tomorrow = result[1] as List<TaskModel>;
    final week = result[2] as WeekTask;
    todayTasks = TotalTasks(
        total: today.length,
        totalFinished: today.where((element) => element.finalizado).length);

    tomorrowTasks = TotalTasks(
        total: tomorrow.length,
        totalFinished: tomorrow.where((element) => element.finalizado).length);

    weekTasks = TotalTasks(
        total: week.models.length,
        totalFinished:
            week.models.where((element) => element.finalizado).length);

    notifyListeners();
  }
}
