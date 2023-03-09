// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_flutter/app/exception/auth_exception.dart';

import 'package:todo_list_flutter/app/services/user/user_service.dart';

import '../../core/notifier/default_change_notifier.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({
    required UserService userService,
  }) : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> loginUser(String email, String password) async {
    try {
      showLoadingAndReset();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);
      if (user != null) {
        showSucess();
      } else {
        _userService.logout();
        setError('Senha ou email inválidos.');
      }
    } on AuthException catch (e) {
      _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndReset();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset da senha enviado para seu email.';
    } on Exception catch (e) {
      if (e is AuthException) {
        setError(e.message);
      } else {
        setError("Erro ao resetar senha.");
      }
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    try {
      showLoadingAndReset();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.googleLogin();
      if (user != null) {
        showSucess();
      } else {
        setError('Erro ao realizar login Google.');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
