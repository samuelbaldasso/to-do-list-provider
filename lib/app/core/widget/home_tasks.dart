// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/core/widget/task.dart';
import 'package:todo_list_flutter/app/models/task_fliter_enum.dart';
import 'package:todo_list_flutter/app/models/task_model.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';
import 'package:todo_list_flutter/app/services/task/task_service.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({
    Key? key,
  }) : super(key: key);
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
          Visibility(
            visible: context.select<HomeController, bool>((value) {
              return value.showFinishingTasks;
            }),
            child: TextButton.icon(
              onPressed: () {
                context.read<HomeController>().showOrHideFinishingTasks();
              },
              icon: Icon(
                Icons.delete,
                color: context.primaryColor,
              ),
              label: Text(
                "Limpar Filtros",
                style: context.titleStyle.copyWith(fontSize: 8),
              ),
            ),
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
