// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_flutter/app/models/task_model.dart';

class WeekTask {
  final DateTime start;
  final DateTime end;
  final List<TaskModel> models;

  WeekTask({
    required this.start,
    required this.end,
    required this.models,
  });
}
