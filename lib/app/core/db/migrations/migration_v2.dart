import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list_flutter/app/core/db/migrations/migration.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute("create table teste(id integer)");
  }

  @override
  void update(Batch batch) {
    batch.execute("create table teste(id integer)");
  }
}
