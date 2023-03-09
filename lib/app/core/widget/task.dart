import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
          child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading: Checkbox(
          onChanged: (value) {},
          value: true,
        ),
        title: Text(
          'DESCRIÇÃO DA TASK',
          style: TextStyle(
            decoration: true ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '20/07/2022',
          style: TextStyle(
            decoration: true ? TextDecoration.lineThrough : null,
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
            BoxShadow(color: Colors.grey),
          ]),
    );
  }
}
