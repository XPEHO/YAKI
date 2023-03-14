import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:crypt/crypt.dart';

class LoginNotifier extends StateNotifier<int> {
  final LoginRepository repository;

  LoginNotifier(
    this.repository,
  ) : super(0);

  Future<String?> changeLogin(String newLogin, String newPassword) async {
    final hashPass = Crypt.sha256(
      newPassword,
      rounds: 10000,
      salt: const String.fromEnvironment('CRED_HASH_PASS'),
    );
    final newLog = Login(login: newLogin, password: hashPass.toString());

    final userLoggedIn = await repository.postLogin(newLog);
    return userLoggedIn;
  }
}
