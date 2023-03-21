import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/data/models/user.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/data/sources/remote/login_api.dart';
import 'package:yaki/domain/entities/logged_user.dart';

class LoginRepository {
  final LoginApi _loginApi;
  LoggedUser? loggedUser;
  // isCaptain determine redirection after login.
  bool? isCaptain = false;

  LoginRepository(
    this._loginApi, {
    this.loggedUser,
    this.isCaptain,
  });

  Future<bool> userAuthentication(String login, String password) async {
    Login newLog = Login(login: login, password: password);
    try {
      final authenticationResponse = await _loginApi.postLogin(newLog);
      // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
      final userResponse = User.fromJson(authenticationResponse.data);

      final statusCode = authenticationResponse.response.statusCode;
      switch (statusCode) {
        case 200:
          setSharedPreference(userResponse);
          setLoggedUser(userResponse);
          if (userResponse.captainId != null) {
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
          throw Exception(authenticationResponse.response.statusMessage);
      }
    } catch (err) {
      debugPrint('login exception : $err');
    }
    return isCaptain!;
  }

  /// Attributes from User model,
  /// to be saved into sharedPreferences.
  void setSharedPreference(User user) {
    addTokenToSharedPreference(user.token);
    addUserIdToSharedPreference(user.userId);
  }

  /// Retrieve User model attributes
  /// and assign the selected attributes to the loggedUser entities
  void setLoggedUser(User user) {
    loggedUser = LoggedUser(
      teamMateid: user.teamMateId ?? 0,
      lastName: user.lastName ?? "",
      firstName: user.firstName ?? "",
      email: user.email ?? "",
    );
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
