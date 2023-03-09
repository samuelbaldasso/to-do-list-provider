// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_flutter/app/exception/auth_exception.dart';

import './user_repo.dart';

class UserRepoImpl implements UserRepo {
  final FirebaseAuth _auth;

  UserRepoImpl({
    required FirebaseAuth auth,
  }) : _auth = auth;

  @override
  Future<User?> registerUser(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print("$e, $s");
      }
      if (e.code == 'email-already-in-use') {
        final loginTypes = await _auth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(message: "Email já utilizado...");
        } else {
          throw AuthException(
              message:
                  "Você se cadastrou pelo Google. Por favor, utilize-o...");
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar o user.');
      }
    }
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print('$e, $s');
      throw AuthException(message: e.message ?? 'Erro ao realizar login.');
    } on FirebaseAuthException catch (e, s) {
      print('$e, $s');
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Login falhou. Senha incorreta.');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login.');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods = await _auth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains('password')) {
        await _auth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                'Cadastro realizado com o Google, não pode ser resetado a senha.');
      } else {
        throw AuthException(message: 'Login não encontrado.');
      }
    } on PlatformException catch (e, s) {
      print('$e, $s');
      throw AuthException(message: 'Erro ao resetar senha.');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String> loginMethods = [];
    try {
      final googleSignIn = GoogleSignIn();
      final user = await googleSignIn.signIn();
      if (user != null) {
        loginMethods = await _auth.fetchSignInMethodsForEmail(user.email);
        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'Você utilizou o email para cadastro. Caso tenha esquecido, clicar em Esqueci minha senha.');
        } else {
          final googleAuth = await user.authentication;
          final firebaseProvider = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          final userCredential =
              await _auth.signInWithCredential(firebaseProvider);
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      print('$e, $s');
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                '''Login inválido. Você se cadstrou com os seguintes provedores: 
                ${loginMethods.join(',')}''');
      } else {
        throw AuthException(message: 'Erro ao realizar login.');
      }
    }
    return null;
  }

  @override
  Future<void> googleLogout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
    }
    user!.reload();
  }
}
