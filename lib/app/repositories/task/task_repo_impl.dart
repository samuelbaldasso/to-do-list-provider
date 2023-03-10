// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_flutter/app/core/db/sqlite_conn_factory.dart';
import 'package:todo_list_flutter/app/core/widget/task.dart';
import 'package:todo_list_flutter/app/models/task_model.dart';
import 'package:todo_list_flutter/app/repositories/task/task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final SqLiteConnFactory _sqLiteConnFactory;

  TaskRepoImpl({
    required SqLiteConnFactory sqLiteConnFactory,
  }) : _sqLiteConnFactory = sqLiteConnFactory;

  @override
  Future<void> saveTask(DateTime dateTime, String description) async {
    final conn = await _sqLiteConnFactory.openConn();
    await conn.insert('todo', {
      'id': null,
      'descricao': description,
      'datahora': dateTime.toIso8601String(),
      'finalizado': 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(
      start.year,
      start.month,
      start.day,
      0,
      0,
      0,
    );

    final endFilter = DateTime(
      end.year,
      end.month,
      end.day,
      23,
      59,
      59,
    );

    final sql = await _sqLiteConnFactory.openConn();
    final result = await sql.rawQuery(
        "select * from todo where datahora between ? and ? order by datahora",
        [startFilter.toIso8601String(), endFilter.toIso8601String()]);

    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await _sqLiteConnFactory.openConn();
    final finished = task.finalizado ? 1 : 0;

    await conn.rawUpdate(
        "update todo set finalizado = ? where id = ?", [finished, task.id]);
  }

  @override
  Future<void> deleteAll() async {
    final conn = await _sqLiteConnFactory.openConn();
    await conn.delete("todo");
  }

  @override
  Future<void> deleteById(int id) async {
    final conn = await _sqLiteConnFactory.openConn();
    await conn.rawDelete("delete from todo where id = ?", [id]);
  }
}
