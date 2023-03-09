import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/ui/messages.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';
import 'package:todo_list_flutter/app/services/user/user_service.dart';

import '../auth/auth_provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  var valueVN = ValueNotifier<String>('');
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Selector<AuthProvider, String>(
                  selector: (context, auth) =>
                      auth.user?.photoURL ??
                      'https://avatars.githubusercontent.com/u/53982121?v=4',
                  builder: (context, value, child) => CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider, String>(
                      selector: (context, auth) =>
                          auth.user?.displayName ?? 'Nome do usuário',
                      builder: (context, value, child) => Text(
                        value,
                        style: context.textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        ListTile(
          title: Text('Alterar nome'),
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Alterar nome'),
              content: TextField(
                onChanged: (value) {
                  valueVN.value = value;
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (valueVN.value.isEmpty) {
                      Messages.of(context).showError("Preencha um nome.");
                    } else {
                      await context
                          .read<UserService>()
                          .updateDisplayName(valueVN.value);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Alterar"),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          onTap: () => context.read<AuthProvider>().logout(),
          title: Text('Logout'),
        ),
      ]),
    );
  }
}
