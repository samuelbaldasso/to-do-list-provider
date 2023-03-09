import 'package:flutter/material.dart';

import '../ui/my_flutter_app_icons.dart';

class ToDoListField extends StatelessWidget {
  ToDoListField({
    super.key,
    required this.label,
    this.obscure = false,
    this.suffix,
    this.controller,
    this.validator,
    this.focusNode,
    this.onChanged,
  })  : assert(obscure == true ? suffix == null : true,
            'Obscure text não pode ser enviado com suffix...'),
        obscureVN = ValueNotifier(obscure);

  final String label;
  final bool obscure;
  final IconButton? suffix;
  final ValueNotifier<bool> obscureVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final FunctionString onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: obscureVN,
        builder: (_, value, child) {
          return TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              isDense: true,
              suffixIcon: suffix ??
                  (obscure == true
                      ? IconButton(
                          onPressed: () {
                            obscureVN.value = !value;
                          },
                          icon: Icon(
                            !value
                                ? ToDoListIcons.eye
                                : ToDoListIcons.eye_slash,
                            size: 15,
                          ),
                        )
                      : null),
            ),
            obscureText: value,
          );
        });
  }
}

typedef FunctionString = void Function(String)?;
