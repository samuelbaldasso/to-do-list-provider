import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/modules/to_do_list.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';
import 'package:todo_list_flutter/app/modules/home/home_page.dart';
import 'package:todo_list_flutter/app/modules/tasks/tasks_module.dart';
import 'package:todo_list_flutter/app/repositories/task/task_repo.dart';
import 'package:todo_list_flutter/app/repositories/task/task_repo_impl.dart';
import 'package:todo_list_flutter/app/services/task/task_service.dart';
import 'package:todo_list_flutter/app/services/task/task_service_impl.dart';

class HomeModule extends ToDoListModule {
  HomeModule()
      : super(routers: {
          '/home': (context) => HomePage(
                homeController: context.read(),
              ),
        }, bindings: [
          Provider<TaskRepo>(
            create: (context) =>
                TaskRepoImpl(sqLiteConnFactory: context.read()),
          ),
          Provider<TaskService>(
            create: (context) => TaskServiceImpl(taskRepo: context.read()),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeController(taskService: context.read()),
          )
        ]);
}
