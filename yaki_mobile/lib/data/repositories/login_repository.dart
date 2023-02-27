import 'package:yaki/data/sources/login_api.dart';

import '../models/login.dart';

class LoginRepository {
  final LoginService _loginService;

  LoginRepository(this._loginService);

  postLogin() async {
    await _loginService.postLogin();
  }

}