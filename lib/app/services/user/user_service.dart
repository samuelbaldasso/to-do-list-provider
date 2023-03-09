import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  Future<User?> register(String email, String password) async {}
  Future<User?> login(String email, String password) async {}
  Future<void> forgotPassword(String email) async {}
  Future<User?> googleLogin() async {}
  Future<void> logout() async {}
  Future<void> updateDisplayName(String name) async {}
}
