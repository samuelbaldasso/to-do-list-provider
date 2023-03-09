// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_flutter/app/exception/auth_exception.dart';

import 'package:todo_list_flutter/app/services/user/user_service.dart';

import '../../../core/notifier/default_change_notifier.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndReset();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        showSucess();
      } else {
        setError('Erro ao cadastrar user.');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
