import 'package:flutter/material.dart';
import 'package:yaki/data/models/user_registration_model.dart';
import 'package:yaki/data/sources/remote/user_register_repository.dart';
import 'package:yaki/domain/entities/user_registered.dart';

class UserRegistrationService {
  UserRegistered userRegistered = UserRegistered(isRegistered: false);

  final UserRegisterRepository _userRegisterRepository;
  UserRegistrationService(this._userRegisterRepository);

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
          await _userRegisterRepository.userResgistration(userToRegister);
      final statusCode = getHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          userRegistered = UserRegistered.fromJson(getHttpResponse.data);
          break;
        case 400:
          debugPrint("Error during account creation");
          break;
        default:
          throw Exception(
            "Invalid statusCode : $statusCode",
          );
      }
    } catch (err) {
      debugPrint('Error during user registration : $err');
    }
  }
}
