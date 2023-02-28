import 'package:yaki/data/sources/login_api.dart';

import '../../presentation/state/login_state.dart';
import '../models/login.dart';

class LoginRepository {
  final LoginService _loginService;

  LoginRepository(this._loginService);

  Future<Login?> postLogin(Login login) {
    final log = _loginService.postLogin(login);
    return log;
  }

}