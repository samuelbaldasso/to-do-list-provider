import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/core/widget/todo_card_fliter.dart';
import 'package:todo_list_flutter/app/models/task_fliter_enum.dart';
import 'package:todo_list_flutter/app/models/task_model.dart';
import 'package:todo_list_flutter/app/models/total_tasks.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ToDoCardFilter(
                label: "HOJE",
                filter: TaskFilterEnum.today,
                tasksModel: context.select<HomeController, TotalTasks?>(
                    (value) => value.todayTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.selected) ==
                    TaskFilterEnum.today,
              ),
              ToDoCardFilter(
                label: "AMANHÃ",
                filter: TaskFilterEnum.tomorrow,
                tasksModel: context.select<HomeController, TotalTasks?>(
                    (value) => value.tomorrowTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.selected) ==
                    TaskFilterEnum.tomorrow,
              ),
              ToDoCardFilter(
                label: "SEMANA",
                filter: TaskFilterEnum.week,
                tasksModel: context.select<HomeController, TotalTasks?>(
                    (value) => value.weekTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.selected) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
