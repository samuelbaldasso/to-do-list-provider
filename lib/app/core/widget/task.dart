import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/ui/messages.dart';
import 'package:todo_list_flutter/app/models/task_model.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  Task({super.key, required this.model});
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => _buildConfirmDismiss(context),
      onDismissed: (direction) async {
        await context.read<HomeController>().deleteTask(model);
        Messages.of(context).showInfo("Task deletada com sucesso!");
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: IntrinsicHeight(
            child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            onChanged: (value) {
              context.read<HomeController>().checkOrUncheckTask(model);
              if (model.finalizado) {}
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
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20),
          //   side: const BorderSide(width: 1),
          // ),
        )),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              const BoxShadow(color: Colors.grey),
            ]),
      ),
    );
  }

  Future<bool> _buildConfirmDismiss(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Excluir"),
          content: Text("Confirma a exclusão da task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Sim"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Não"),
            ),
          ],
        );
      },
    );
  }
}
