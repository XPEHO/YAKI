import 'package:yaki/data/sources/login_api.dart';
import 'package:yaki/data/models/login.dart';

class LoginRepository {
  final LoginService _loginService;

  LoginRepository(this._loginService);

  Future<Login?> postLogin(Login login) {
    final log = _loginService.postLogin(login);
    return log;
  }

}