import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/modules/to_do_list.dart';
import 'package:todo_list_flutter/app/modules/auth/login_controller.dart';
import 'package:todo_list_flutter/app/modules/auth/register/register_controller.dart';
import 'package:todo_list_flutter/app/modules/auth/register/register_page.dart';
import 'package:todo_list_flutter/app/modules/auth/login_page.dart';

class AuthModule extends ToDoListModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => LoginController(userService: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  RegisterController(userService: context.read()),
            )
          ],
          routers: {
            "/login": (context) => const LoginPage(),
            "/register": (context) => const RegisterPage()
          },
        );
}
