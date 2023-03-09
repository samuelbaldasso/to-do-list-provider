import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/modules/tasks/tasks_create_controller.dart';

class CalendarButton extends StatelessWidget {
  CalendarButton({super.key});

  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(const Duration(days: 3 * 365));

        final DateTime? selectedTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate,
        );
        context.read<TasksCreateController>().selectedTime = selectedTime;
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.today,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Selector<TasksCreateController, DateTime?>(
              builder: (context, selectedDate, child) {
                if (selectedDate != null) {
                  return Text(
                    dateFormat.format(selectedDate),
                    style: context.titleStyle,
                  );
                } else {
                  return Text(
                    'SELECIONE UMA DATA',
                    style: context.titleStyle,
                  );
                }
              },
              selector: (context, provider) => provider.selectedTime,
            ),
          ],
        ),
      ),
    );
  }
}
