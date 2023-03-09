import 'package:flutter/material.dart';
import 'package:todo_list_flutter/app/core/notifier/default_listener.dart';
import 'package:todo_list_flutter/app/core/ui/messages.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/core/widget/calendar_button.dart';
import 'package:todo_list_flutter/app/core/widget/to_do_list_field.dart';
import 'package:todo_list_flutter/app/modules/tasks/tasks_create_controller.dart';
import 'package:validatorless/validatorless.dart';

class TasksCreatePage extends StatefulWidget {
  const TasksCreatePage({super.key, required TasksCreateController controller})
      : _controller = controller;
  final TasksCreateController _controller;

  @override
  State<TasksCreatePage> createState() => _TasksCreatePageState();
}

class _TasksCreatePageState extends State<TasksCreatePage> {
  final _description = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DefaultListener(
      change: widget._controller,
    ).listener(
      context: context,
      successCall: (notifier, listener) {
        listener.dispose();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Salvar task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.primaryColor,
        onPressed: () {
          final formValid = _key.currentState?.validate() ?? false;
          if (formValid) {
            widget._controller.save(_description.text);
          }
        },
      ),
      body: Form(
        key: _key,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Criar task',
                  style: context.titleStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ToDoListField(
                label: 'Descrição',
                controller: _description,
                validator: Validatorless.required('Descrição obrigatória.'),
              ),
              SizedBox(
                height: 20,
              ),
              CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
