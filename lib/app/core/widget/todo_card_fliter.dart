import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/models/task_fliter_enum.dart';
import 'package:todo_list_flutter/app/models/total_tasks.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';

class ToDoCardFilter extends StatelessWidget {
  const ToDoCardFilter(
      {super.key,
      required this.label,
      required this.filter,
      this.tasksModel,
      required this.selected});

  final String label;
  final TaskFilterEnum filter;
  final TotalTasks? tasksModel;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: filter),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 120,
          maxWidth: 150,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // SizedBox(height: 21, width: 21, child: CircularProgressIndicator(),),
          Text(
            '${tasksModel?.total ?? 0} TASKS',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          Text(
            label,
            style: context.titleStyle.copyWith(
              fontSize: 20,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
          TweenAnimationBuilder<double>(
            duration: Duration(seconds: 1),
            tween: Tween(begin: 0.0, end: _getPercent()),
            builder: (BuildContext context, Object? value, Widget? child) {
              return LinearProgressIndicator(
                backgroundColor:
                    selected ? context.primaryColorLight : Colors.grey.shade300,
                value: 0.4,
                valueColor: AlwaysStoppedAnimation<Color>(
                    selected ? Colors.white : context.primaryColor),
              );
            },
          ),
        ]),
      ),
    );
  }

  double _getPercent() {
    final total = tasksModel?.total ?? 0;
    final totalFinished = tasksModel?.totalFinished ?? 0.1;
    if (total == 0) {
      return 0;
    }
    final percent = (totalFinished * 100) / total;
    return percent / 100;
  }
}
