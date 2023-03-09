import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list_flutter/app/core/db/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute(
        'create table todo(id Integer primary key autoincrement, descricao varchar(500) not null, datahora datetime, finalizado Integer)');
  }

  @override
  void update(Batch batch) {}
}
