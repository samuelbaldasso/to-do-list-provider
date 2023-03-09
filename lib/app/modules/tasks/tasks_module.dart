import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/modules/to_do_list.dart';
import 'package:todo_list_flutter/app/modules/tasks/tasks_create_controller.dart';
import 'package:todo_list_flutter/app/modules/tasks/tasks_create_page.dart';
import 'package:todo_list_flutter/app/repositories/task/task_repo.dart';
import 'package:todo_list_flutter/app/repositories/task/task_repo_impl.dart';
import 'package:todo_list_flutter/app/services/task/task_service.dart';
import 'package:todo_list_flutter/app/services/task/task_service_impl.dart';

class TasksModule extends ToDoListModule {
  TasksModule()
      : super(
          bindings: [
            Provider<TaskRepo>(
              create: (context) =>
                  TaskRepoImpl(sqLiteConnFactory: context.read()),
            ),
            Provider<TaskService>(
              create: (context) => TaskServiceImpl(taskRepo: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  TasksCreateController(taskService: context.read()),
            )
          ],
          routers: {
            '/tasks/create': (context) => TasksCreatePage(
                  controller: context.read(),
                ),
          },
        );
}
