import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/password_changement_out.dart';
import 'package:yaki/data/models/password_forgot_out.dart';
import 'package:yaki/data/sources/remote/password_api.dart';

class PasswordRepository {
  final PasswordApi _passwordApi;

  PasswordRepository(this._passwordApi);

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? loggedUserId = prefs.getInt("userId");
    if (loggedUserId == null) {
      // shouldn't happen when a user is successfully logged in, but just in case.
      debugPrint("password registration : userId is null");
      return false;
    }

    PasswordChangementOut passwordChangementOut = PasswordChangementOut(
      userId: loggedUserId,
      currentPassword: oldPassword,
      newPassword: newPassword,
    );

    try {
      final changePasswordResponse =
          await _passwordApi.postChangePassword(passwordChangementOut);
      final statusCode = changePasswordResponse.response.statusCode;
      switch (statusCode) {
        case 200:
          debugPrint("password changed, $passwordChangementOut");
          return true;
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during password changement : $err');
    }
    return false;
  }

  Future<bool> forgotPassword(String email) async {
    PasswordForgotOut passwordForgotOut = PasswordForgotOut(email: email);

    try {
      final forgotPasswordResponse =
          await _passwordApi.postForgotPassword(passwordForgotOut);
      final statusCode = forgotPasswordResponse.response.statusCode;
      switch (statusCode) {
        case 200:
          debugPrint("Email sent, $email");
          return true;
        default:
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      debugPrint('error during password changement : $err');
    }
    return false;
  }
}
