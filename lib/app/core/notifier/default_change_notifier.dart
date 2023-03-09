import 'package:flutter/material.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  bool _sucess = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get isSucess => _sucess;

  void showLoading() => _loading = true;

  void setError(String? error) => _error = error;

  void showSucess() => _sucess = true;

  void hideLoading() => _loading = false;

  void showLoadingAndReset() {
    showLoading();
    resetState();
  }

  void resetState() {
    setError(null);
    _sucess = false;
  }
}
