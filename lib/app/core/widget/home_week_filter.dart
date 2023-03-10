import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/models/task_fliter_enum.dart';
import 'package:todo_list_flutter/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, TaskFilterEnum>(
              (value) => value.selected) ==
          TaskFilterEnum.week,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'DIAS DA SEMANA',
            style: context.titleStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 95,
              child: Selector<HomeController, DateTime>(
                selector: (context, controller) =>
                    controller.initialDate ?? DateTime.now(),
                builder: (context, value, child) => DatePicker(value,
                    locale: 'pt_BR',
                    initialSelectedDate: value,
                    selectionColor: context.primaryColor,
                    selectedTextColor: Colors.white,
                    daysCount: 7,
                    monthTextStyle: TextStyle(fontSize: 8),
                    dayTextStyle: TextStyle(fontSize: 13),
                    dateTextStyle: TextStyle(fontSize: 13),
                    onDateChange: (selectedDate) {
                  context.read<HomeController>().filterByDay(selectedDate);
                }),
              )),
        ],
      ),
    );
  }
}
