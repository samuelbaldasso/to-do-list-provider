import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/auth/auth_provider.dart';
import 'package:todo_list_flutter/app/core/modules/to_do_list.dart';
import 'package:todo_list_flutter/app/core/notifier/default_listener.dart';
import 'package:todo_list_flutter/app/core/ui/my_flutter_app_icons.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/core/widget/home_drawer.dart';
import 'package:todo_list_flutter/app/core/widget/home_fliters_ui.dart';
import 'package:todo_list_flutter/app/core/widget/home_header.dart';
import 'package:todo_list_flutter/app/core/widget/home_tasks.dart';
import 'package:todo_list_flutter/app/core/widget/home_week_filter.dart';
import 'package:todo_list_flutter/app/models/task_fliter_enum.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';
import 'package:todo_list_flutter/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required HomeController homeController})
      : _homeController = homeController;
  final HomeController _homeController;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaultListener(change: widget._homeController).listener(
      context: context,
      successCall: (notifier, listener) {
        listener.dispose();
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._homeController.loadAllTasks();
      widget._homeController.findTasks(filter: TaskFilterEnum.today);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _goToCreateTask(BuildContext context) async {
      await Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
            return ScaleTransition(
              scale: animation,
              alignment: Alignment.bottomRight,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return TasksModule().getPage('/tasks/create', context);
          },
        ),
      );
      widget._homeController.refreshPage();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: Color(0xfffafbfe),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(ToDoListIcons.filter),
            itemBuilder: (context) => [
              PopupMenuItem<bool>(
                child: Text('Mostrar tarefas concluídas'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCreateTask(context),
        child: Icon(Icons.add),
        backgroundColor: context.primaryColor,
      ),
      backgroundColor: Color(0xfffafbfe),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (p0, p1) => SingleChildScrollView(
            child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: p1.maxHeight, minWidth: p1.maxWidth),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: IntrinsicHeight(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(),
                HomeFilters(),
                HomeWeekFilter(),
                HomeTasks(),
              ],
            )),
          ),
        )),
      ),
    );
  }
}
