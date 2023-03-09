import 'package:flutter/material.dart';

class Validators {
  Validators._();
  static FormFieldValidator validatorCompare(
      TextEditingController? tec, String message) {
    return (value) {
      final valueCompare = tec?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return message;
      }
    };
  }
}
