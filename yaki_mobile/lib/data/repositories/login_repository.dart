import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/authentication.dart';
import 'package:yaki/data/sources/Local/token_shared_preference.dart';
import 'package:yaki/data/sources/remote/login_api.dart';
import 'package:yaki/data/models/login.dart';

class LoginRepository {
  final LoginService _loginService;

  LoginRepository(this._loginService);

  Future<Authentication?> postLogin(Login login) async {
    final authenticationResponse = await _loginService.postLogin(login);

    addTokenToSF(authenticationResponse?.token);
  }
}
