import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/auth/auth_provider.dart' as auth_provider;
import 'package:todo_list_flutter/app/core/db/sqlite_conn_factory.dart';
import 'package:todo_list_flutter/app/repositories/user/user_repo.dart';
import 'package:todo_list_flutter/app/repositories/user/user_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_flutter/app/services/user/user_service.dart';
import 'package:todo_list_flutter/app/services/user/user_service_impl.dart';

import 'app_widget.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => FirebaseAuth.instance,
        ),
        Provider(
          create: (context) => SqLiteConnFactory(),
          lazy: false,
        ),
        Provider<UserRepo>(
          create: (context) => UserRepoImpl(auth: context.read()),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(userRepo: context.read()),
        ),
        ChangeNotifierProvider(
            create: (context) => auth_provider.AuthProvider(
                firebaseAuth: context.read(), userService: context.read())
              ..loadListener(),
            lazy: false)
      ],
      child: const AppWidget(),
    );
  }
}
