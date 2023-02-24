import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState(login:"", password: ""));

  void changeLogin(String newLogin, String newPassword) {
    state = LoginState(login: newLogin, password: newPassword);
  }
}