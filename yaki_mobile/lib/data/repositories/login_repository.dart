import 'package:flutter/cupertino.dart';
import 'package:retrofit/dio.dart';
import 'package:yaki/data/models/authentication.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/data/sources/remote/login_api.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/domain/entities/logged_user.dart';

class LoginRepository {
  final LoginApi _loginService;
  LoggedUser? loggedUser;

  LoginRepository(this._loginService);

  /// Methode invoking the API postLogin method to POST log informations.
  /// then retreive the status code from handleResponse method.
  Future<int?> postLogin(Login login) async {
    final authenticationResponse = await _loginService.postLogin(login);
    return handleResponse(authenticationResponse);
  }

  /// Save the token into the sharedPreference and generate the loggedUser values only if
  /// response statusCode == 200.
  /// Otherwise, debuglog the statuscode (for now).
  /// Return the statusCode in order to use it, to determine if user can go to the next page.
  int? handleResponse(HttpResponse<Authentication?> response) {
    final statusCode = response.response.statusCode;
    final data = response.data!;
    try {
      if (statusCode == 200) {
        addTokenToSharedPreference(response.data!.token);
        loggedUser = LoggedUser(
          teamMateid: data.teamMateId!,
          lastName: data.lastName,
          firstName: data.firstName,
          email: data.email,
        );
      } else if (statusCode == 401) {
        debugPrint("Invalid token, code : $statusCode");
      } else if (statusCode == 204) {
        debugPrint("invalid login informations, code : $statusCode");
      }
    } catch (exception) {
      debugPrint('login exception : $exception');
    }
    return statusCode;
  }

  /// teamMateId getter, used at declaration object creation, in order to POST it.
  int get teamMateId {
    return loggedUser!.teamMateid;
  }
}
