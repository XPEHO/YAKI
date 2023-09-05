import 'package:flutter/cupertino.dart';
import 'package:yaki/data/models/login_model.dart';
import 'package:yaki/data/models/user.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/data/sources/remote/login_api.dart';
import 'package:yaki/domain/entities/logged_user.dart';

class LoginRepository {
  final LoginApi _loginApi;
  LoggedUser? loggedUser;

  LoginRepository(
    this._loginApi, {
    this.loggedUser,
  });

  /// Invoked at sign in button press in authentication page.
  ///
  /// Receive a HttpResponse, with :
  /// * HttpResponse.response, get the response statusCode
  /// * HttpResponse.data to get the data from the response body
  /// Depending of the response statusCode corresponding actions are set
  ///
  /// At statusCode 200 :
  /// * convert the HttpResponse.data into a User model instance,
  /// * setSharedPreference() save token & userId to the sharedPreference
  /// * setLoggedUser() create the LoggedUser instance: front available information's.
  Future<bool> userAuthentication(String login, String password) async {
    bool authenticationSuccess = false;

    LoginModel newLog = LoginModel(login: login, password: password);

    try {
      final authenticationResponse = await _loginApi.postLogin(newLog);

      final statusCode = authenticationResponse.response.statusCode;

      if (statusCode == 200) {
        // convert HttpResponse<dynamic> (Map<String, dynamic>) into Model using .fromJson method
        final userResponse = User.fromJson(authenticationResponse.data);
        setSharedPreference(userResponse);
        setLoggedUser(userResponse);
        authenticationSuccess = true;
      } else {
        switch (statusCode) {
          case 204:
            debugPrint("invalid login informations, code : $statusCode");
            break;
          case 401:
            debugPrint("Invalid token, code : $statusCode");
            break;
          default:
            throw Exception('Invalid statusCode : $statusCode');
        }
      }
    } catch (err) {
      debugPrint('error during userAuthentication : $err');
    }
    return authenticationSuccess;
  }

  /// Attributes from User model,
  /// to be saved into sharedPreferences.
  void setSharedPreference(User user) async {
    SharedPref.setToken(user.token);
    SharedPref.setUserId(user.userId);
  }

  /// Retrieve User model attributes
  /// and assign the selected attributes to the loggedUser entities
  /// entities are the class connected to the front.
  void setLoggedUser(User user) {
    loggedUser = LoggedUser(
      userId: user.userId,
      captainId: user.captainId,
      teammateId: user.teammateId,
      lastName: user.lastName ?? "",
      firstName: user.firstName ?? "",
      email: user.email ?? "",
    );
  }

  /// userId getter, used at declaration object creation, in order to POST it.
  int? get userId {
    return loggedUser?.userId;
  }

  /// captainId getter, used in team_mate_notifier to fetch the teammate list associated to the logged captain.
  int? get captainId {
    return loggedUser?.captainId;
  }

  /// teammateId getter, used in authentication page to determine if the user is part of a team
  int? get teammateId {
    return loggedUser?.teammateId;
  }

  // Check if the user stored in the repository is a captain or a teamMate
  bool isCaptain() {
    if (loggedUser!.captainId != null) {
      return true;
    }
    return false;
  }

  // Check if the user stored in the repository is a captain or a teamMate
  bool isTeammate() {
    if (loggedUser!.teammateId != null) {
      return true;
    }
    return false;
  }
}
