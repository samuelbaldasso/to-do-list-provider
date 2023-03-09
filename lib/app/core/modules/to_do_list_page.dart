// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ToDoListPage extends StatelessWidget {
  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder _page;

  ToDoListPage({
    Key? key,
    List<SingleChildWidget>? bindings,
    required WidgetBuilder page,
  })  : _bindings = bindings,
        _page = page,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings ??
          [
            Provider(
              create: (context) => Object(),
            )
          ],
      child: Builder(
        builder: (context) => _page(context),
      ),
    );
  }
}
