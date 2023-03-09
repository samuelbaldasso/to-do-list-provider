import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/notifier/default_listener.dart';
import 'package:todo_list_flutter/app/core/ui/messages.dart';
import 'package:todo_list_flutter/app/core/widget/to_do_list_field.dart';
import 'package:todo_list_flutter/app/core/widget/to_do_list_logo.dart';
import 'package:todo_list_flutter/app/modules/auth/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListener(change: context.read<LoginController>()).listener(
      context: context,
      everCall: (notifier, listener) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
      successCall: (notifier, listener) {
        // listener.dispose();
        print("Login efetuado.");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth),
              child: IntrinsicHeight(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 10),
                  const ToDoListLogo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ToDoListField(
                            label: "Email",
                            controller: _email,
                            validator: Validatorless.multiple([
                              Validatorless.email('Email inválido.'),
                              Validatorless.required('Email obrigatório.')
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
                              Validatorless.min(6, 'Mínimo de 6 caracteres.'),
                              Validatorless.required('Senha obrigatória.'),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (_email.text.isNotEmpty) {
                                    context
                                        .read<LoginController>()
                                        .forgotPassword(_email.text);
                                  } else {
                                    _emailFocus.requestFocus();
                                    Messages.of(context).showError(
                                        'Digite um e-mail para recuperar a senha.');
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Esqueceu sua senha?'),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final formValid =
                                      _formKey.currentState?.validate() ??
                                          false;

                                  if (formValid) {
                                    final email = _email.text;
                                    final password = _password.text;
                                    context
                                        .read<LoginController>()
                                        .loginUser(email, password);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFf0f3f7),
                        border: Border(
                            top: BorderSide(
                                width: 2, color: Colors.grey.withAlpha(50))),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SignInButton(Buttons.Google,
                              text: "Continue com o Google",
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ), onPressed: () {
                            context.read<LoginController>().googleLogin();
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Não tem conta?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("/register");
                                },
                                child: const Text("Cadastre-se"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
