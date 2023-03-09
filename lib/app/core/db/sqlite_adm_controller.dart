import 'package:flutter/material.dart';
import 'package:todo_list_flutter/app/core/db/sqlite_conn_factory.dart';

class SqliteAdmController with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final conn = SqLiteConnFactory();
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        conn.closeConn();
        break;
    }
  }
}
