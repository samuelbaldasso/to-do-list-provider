// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list_flutter/app/repositories/user/user_repo.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepo _userRepo;

  UserServiceImpl({
    required UserRepo userRepo,
  }) : _userRepo = userRepo;

  @override
  Future<User?> register(String email, String password) =>
      _userRepo.registerUser(email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepo.loginUser(email, password);

  @override
  Future<void> forgotPassword(String email) => _userRepo.forgotPassword(email);

  @override
  Future<User?> googleLogin() => _userRepo.googleLogin();

  @override
  Future<void> logout() async {
    _userRepo.googleLogout();
  }

  @override
  Future<void> updateDisplayName(String name) async =>
      _userRepo.updateDisplayName(name);
}
