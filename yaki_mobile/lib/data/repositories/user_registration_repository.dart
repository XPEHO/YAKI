import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yaki/data/models/user_registration_model.dart';
import 'package:yaki/data/sources/remote/user_register_api.dart';
import 'package:yaki/domain/entities/user_registered.dart';

class UserRegistrationRepository {
  UserRegistered userRegistered = UserRegistered(isRegistered: false);
  String status = '';
  final UserRegisterApi _userRegisterApi;
  UserRegistrationRepository(this._userRegisterApi);

  Future<void> registerUser({
    required String lastname,
    required String firstname,
    required String email,
    required String password,
  }) async {
    UserRegistrationModel userToRegister = UserRegistrationModel(
      lastname: lastname,
      firstname: firstname,
      email: email,
      password: password,
    );

    try {
      final getHttpResponse =
          await _userRegisterApi.userResgistration(userToRegister);
      final statusCode = getHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          status = "OK";
          userRegistered = UserRegistered.fromJson(getHttpResponse.data);
          break;
        case 400:
          status = "registrationFailed";
          debugPrint("Error during account creation");
          break;
        default:
          status = "registrationFailed";
          debugPrint('statusCode :  $statusCode');
          throw Exception(
            "Invalid statusCode : $statusCode",
          );
      }
    } catch (err) {
      if (err is DioError) {
        final responseStatusCode = err.response?.statusCode ?? -1;
        if (responseStatusCode == 417) {
          status = "registrationInputEmailError";
          debugPrint("registrationInputEmailError");
        } else {
          status = "registrationFailed";
          debugPrint('Error during user registration : $err');
        }
      } else {
        status = "registrationFailed";
        debugPrint('Error during user registration : $err');
      }
    }
  }
}
