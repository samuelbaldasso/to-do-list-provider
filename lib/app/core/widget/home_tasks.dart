import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/core/widget/task.dart';
import 'package:todo_list_flutter/app/models/task_fliter_enum.dart';
import 'package:todo_list_flutter/app/models/task_model.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Selector<HomeController, String>(
            builder: (context, value, child) {
              return Text(
                'TASK\'S $value',
                style: context.titleStyle,
              );
            },
            selector: (p0, p1) => p1.selected.description,
          ),
          Column(
              children: context
                  .select<HomeController, List<TaskModel>>(
                      (value) => value.filteredTasks)
                  .map((e) => Task(
                        model: e,
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
