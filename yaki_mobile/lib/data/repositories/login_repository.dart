import 'package:yaki/data/models/authentication.dart';
import 'package:yaki/data/sources/login_api.dart';
import 'package:yaki/data/models/login.dart';

class LoginRepository {
  final LoginService _loginService;

  LoginRepository(this._loginService);

  Future<Authentication?> postLogin(Login login) async {
    final log = await _loginService.postLogin(login);
    return log;
  }
}
