import 'package:flutter/cupertino.dart';
import 'package:retrofit/dio.dart';
import 'package:yaki/data/models/authentication.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/data/sources/remote/login_api.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/domain/entities/logged_user.dart';

class LoginRepository {
  final LoginApi _loginApi;
  LoggedUser? loggedUser;

  LoginRepository(this._loginApi);

  /// Methode invoking the API postLogin method to POST log informations.
  /// then retreive the status code from handleResponse method.
  Future<String?> postLogin(Login login) async {
    final authenticationResponse = await _loginApi.postLogin(login);
    return handleResponse(authenticationResponse);
  }

  /// Save the token into the sharedPreference and generate the loggedUser values only if
  /// response statusCode == 200.
  /// Otherwise, debuglog the statuscode (for now).
  /// Return the statusCode in order to use it, to determine if user can go to the next page.
  String? handleResponse(HttpResponse<Authentication?> response) {
    final statusCode = response.response.statusCode;
    String userLoggedIn = "";

    try {
      if (statusCode == 200) {
        final data = response.data!;
        addTokenToSharedPreference(response.data!.token);
        loggedUser = LoggedUser(
          teamMateid: data.teamMateId,
          lastName: data.lastName,
          firstName: data.firstName,
          email: data.email,
        );
        userLoggedIn = data.firstName;
      } else if (statusCode == 401) {
        debugPrint("Invalid token, code : $statusCode");
      } else if (statusCode == 204) {
        debugPrint("invalid login informations, code : $statusCode");
      }
    } catch (exception) {
      debugPrint('login exception : $exception');
    }
    return userLoggedIn;
  }

  /// teamMateId getter, used at declaration object creation, in order to POST it.
  int get teamMateId {
    return loggedUser!.teamMateid;
  }
}
