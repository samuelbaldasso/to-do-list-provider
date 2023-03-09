import 'package:todo_list_flutter/app/core/db/migrations/migration.dart';
import 'package:todo_list_flutter/app/core/db/migrations/migration_v1.dart';
import 'package:todo_list_flutter/app/core/db/migrations/migration_v2.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [MigrationV1(), MigrationV2()];
  List<Migration> getUpdateMigration(int version) {
    var migrations = <Migration>[];
    if (version == 1) {
      migrations.add(MigrationV2());
    }
    return migrations;
  }
}
