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

  TaskFilterEnum selected = TaskFilterEnum.today;
  TotalTasks? todayTasks;
  TotalTasks? tomorrowTasks;
  TotalTasks? weekTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDate;
  DateTime? selectedDay;
  bool showFinishingTasks = false;

  Future<void> loadAllTasks() async {
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

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    selected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks = [];

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _taskService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _taskService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _taskService.getWeek();
        initialDate = weekModel.start;
        tasks = weekModel.models;
        break;
      default:
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        filterByDay(selectedDay!);
      } else if (initialDate != null) {
        filterByDay(initialDate!);
      }
    } else {
      selectedDay = null;
    }

    if (!showFinishingTasks) {
      filteredTasks =
          filteredTasks.where((element) => !element.finalizado).toList();
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: selected);
    await loadAllTasks();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task) => task.datehour == date).toList();

    notifyListeners();
  }

  Future<void> checkOrUncheckTask(TaskModel model) async {
    showLoadingAndReset();
    notifyListeners();

    final taskUpdate = model.copyWith(finalizado: !model.finalizado);
    await _taskService.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishingTasks() {
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
  }

  Future<void> deleteById(int id) async {
    showLoadingAndReset();
    notifyListeners();
    await _taskService.deleteById(id);
    hideLoading();
    refreshPage();
  }
}
