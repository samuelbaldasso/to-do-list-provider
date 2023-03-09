// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_flutter/app/core/ui/messages.dart';

import 'default_change_notifier.dart';

class DefaultListener extends ChangeNotifier {
  final DefaultChangeNotifier change;
  DefaultListener({required this.change});

  void listener(
      {required BuildContext context,
      required SucessVoidCallback successCall,
      ErrorVoidCallback? errorCall,
      EverVoidCallback? everCall}) {
    change.addListener(() {
      if (everCall != null) {
        everCall(change, this);
      }
      if (change.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (change.hasError) {
        if (errorCall != null) {
          errorCall(change, this);
        }
        Messages.of(context).showError(change.error ?? 'Erro interno.');
      } else if (change.isSucess) {
        successCall(change, this);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    change.removeListener(() {});
  }
}

typedef SucessVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListener listener);

typedef ErrorVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListener listener);

typedef EverVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListener listener);
