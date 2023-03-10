import 'package:yaki/data/models/authentication.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/data/sources/remote/login_api.dart';
import 'package:yaki/data/models/login.dart';

class LoginRepository {
  final LoginApi _loginService;

  LoginRepository(this._loginService);

  Future<void> postLogin(Login login) async {
    final authenticationResponse = await _loginService.postLogin(login);
    // authenticationResponse can be null if user user incorrect login or password, response can be null
    // need to add null check in this situation

    addTokenToSharedPreference(authenticationResponse.data?.token);
  }
}
