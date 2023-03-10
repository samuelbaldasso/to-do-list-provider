import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/app/core/auth/auth_provider.dart';
import 'package:todo_list_flutter/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthProvider, String>(
        selector: (p0, p1) => p1.user?.displayName ?? 'Não informado',
        builder: (context, value, child) => Text(
          'E aí, $value!',
          style: context.textTheme.headline5
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
