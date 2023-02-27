import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:yaki/presentation/state/login_state.dart';
import 'package:crypt/crypt.dart';

class LoginNotifier extends StateNotifier<LoginState> {

  final LoginRepository repository;

  LoginNotifier(
      this.repository,
      ) : super(
      LoginState(login:"", password: ""),
  );

  void changeLogin(String newLogin, String newPassword) {
    final hashPass = Crypt.sha256(newPassword, rounds: 10000, salt: 'abcdefghijklmnop');
    state = LoginState(login: newLogin, password: hashPass.toString());
  }

  postLogin() async {
    await repository.postLogin();
  }
}