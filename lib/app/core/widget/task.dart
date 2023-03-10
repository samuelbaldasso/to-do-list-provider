import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/models/task_model.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  Task({super.key, required this.model});
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
          child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: Checkbox(
          onChanged: (value) {
            context.read<HomeController>().checkOrUncheckTask(model);
          },
          value: model.finalizado,
        ),
        title: Text(
          model.description,
          style: TextStyle(
            decoration: model.finalizado ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          dateFormat.format(model.datehour),
          style: TextStyle(
            decoration: model.finalizado ? TextDecoration.lineThrough : null,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(width: 1),
        ),
      )),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            const BoxShadow(color: Colors.grey),
          ]),
    );
  }
}
