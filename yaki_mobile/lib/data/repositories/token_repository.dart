import 'package:flutter/material.dart';
import 'package:yaki/data/sources/remote/token_api.dart';

class TokenRepository {
  final TokenApi _tokenApi;

  TokenRepository(
    this._tokenApi,
  );

  Future<bool> verifyTokenValidity() async {
    bool isTokenValid = false;

    try {
      final getHttpResponse = await _tokenApi.verifyTokenValidity();
      final statusCode = getHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          isTokenValid = true;
          break;
        case 401:
          isTokenValid = false;
          break;
        default:
          throw Exception(
            "Invalid statusCode : $statusCode",
          );
      }
    } catch (err) {
      debugPrint('error during verify token validity : $err');
    }
    return isTokenValid;
  }
}
