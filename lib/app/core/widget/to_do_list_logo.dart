import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';

class ToDoListLogo extends StatelessWidget {
  const ToDoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 200,
        ),
        Text(
          "ToDo List",
          style: context.textTheme.headline6,
        ),
      ],
    );
  }
}
