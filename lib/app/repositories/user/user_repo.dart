import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepo {
  Future<User?> registerUser(String email, String password) async {}
  Future<User?> loginUser(String email, String password) async {}
  Future<void> forgotPassword(String email) async {}
  Future<User?> googleLogin() async {}
  Future<void> googleLogout() async {}
  Future<void> updateDisplayName(String name) async {}
}
