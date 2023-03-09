import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list_flutter/app/core/db/sqlite_adm_controller.dart';
import 'package:todo_list_flutter/app/core/navigator/nav.dart';
import 'package:todo_list_flutter/app/core/ui/to_do_list_ui_config.dart';
import 'package:todo_list_flutter/app/modules/auth/auth_module.dart';
import 'package:todo_list_flutter/app/modules/home/home_module.dart';
import 'package:todo_list_flutter/app/modules/tasks/tasks_module.dart';

import 'modules/splash/splash.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqLiteAdm = SqliteAdmController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(sqLiteAdm);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqLiteAdm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      title: 'ToDo List',
      navigatorKey: Nav.navKey,
      initialRoute: '/login',
      home: const SplashPage(),
      theme: ToDoListUiConfig.theme,
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TasksModule().routers
      },
    );
  }
}
