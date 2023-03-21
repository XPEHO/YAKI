import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yaki/data/models/user.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/data/sources/remote/login_api.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:crypt/crypt.dart';

class LoginRepository {
  final LoginApi _loginApi;
  LoggedUser? loggedUser;

  LoginRepository(this._loginApi);

  Future<bool> userAuthentication(String login, String password) async {
    Login newLog = Login(login: login, password: password);
    debugPrint(newLog.password);

    final authenticationResponse = await _loginApi.postLogin(newLog);
    bool isCaptain = handleResponse(authenticationResponse);

    return isCaptain;
  }

  bool handleResponse(HttpResponse<User?> response) {
    bool isCaptain = false;
    try {
      final statusCode = response.response.statusCode;

      switch (statusCode) {
        case 200:
          final data = response.data!;
          addTokenToSharedPreference(data.token);
          addUserIdToSharedPreference(data.userId);
          loggedUser = LoggedUser(
            teamMateid: data.teamMateId,
            lastName: data.lastName,
            firstName: data.firstName,
            email: data.email,
          );

          if (response.data?.captainId != null) {
            isCaptain = true;
          }

          break;
        case 204:
          debugPrint("invalid login informations, code : $statusCode");
          break;
        case 401:
          debugPrint("Invalid token, code : $statusCode");
          break;
        default:
          throw Exception(response.response.statusMessage);
      }
    } catch (err) {
      debugPrint('login exception : $err');
    }

    return isCaptain;
  }

  /// hash password received from authentication page
  /// using crypt.dart library
  String hashPassword(String password) {
    final hashPass = Crypt.sha256(
      password,
      rounds: 10000,
      salt: const String.fromEnvironment('CRED_HASH_PASS'),
    );

    return hashPass.toString();
  }

  /// teamMateId getter, used at declaration object creation, in order to POST it.
  int? get teamMateId {
    return loggedUser?.teamMateid;
  }
}
