import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import 'package:todo_list_flutter/app/core/notifier/default_listener.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/core/widget/to_do_list_field.dart';
import 'package:todo_list_flutter/app/core/widget/to_do_list_logo.dart';
import 'package:todo_list_flutter/app/modules/auth/register/register_controller.dart';
import 'package:todo_list_flutter/app/validators/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  @override
  void initState() {
    super.initState();
    final listener =
        DefaultListener(change: context.read<RegisterController>());
    listener.listener(
      context: context,
      successCall: (notifier, listener) {
        listener.dispose();
        // Navigator.of(context).pop();
      },
      // errorCall: (notifier, listener) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.arrow_back_ios_outlined,
                  size: 20, color: context.primaryColor),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "To Do List",
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            Text(
              "Cadastro",
              style: TextStyle(fontSize: 15, color: context.primaryColor),
            ),
          ],
        ),
      ),
      body: ListView(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: const ToDoListLogo(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ToDoListField(
                    label: "Email",
                    controller: _email,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório.'),
                      Validatorless.email('Email inválido.'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ToDoListField(
                    label: "Senha",
                    obscure: true,
                    controller: _password,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória.'),
                      Validatorless.min(
                          6, 'Senha deve ter pelo menos 6 caracteres.'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ToDoListField(
                    label: "Confirmar Senha",
                    obscure: true,
                    controller: _confirmPassword,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmar senha obrigatória.'),
                      Validators.validatorCompare(
                          _password, 'Senha diferente da senha anterior.'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final form = _formKey.currentState?.validate() ?? false;
                        if (form) {
                          final email = _email.text;
                          final password = _password.text;
                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )),
        )
      ]),
    );
  }
}
