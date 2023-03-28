import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';

void main() {
  SharedPreferences.setMockInitialValues(
    {
      'token': 'initialValue',
      'userId': 0,
    },
  );

  group(
    'sharedPreference function test',
    () {
      test(
        'Add token to sharedPreferences',
        () async {
          const String tokenToAdd = 'azertyuiop';

          SharedPreferences pref = await SharedPreferences.getInstance();

          await SharedPref.setToken(tokenToAdd);
          final String? addedToken = pref.getString('token');

          expect(tokenToAdd == addedToken, true);
        },
      );
      test(
        'Add user if to sharedPreferences',
        () async {
          const int userIdToSet = 2;

          SharedPreferences pref = await SharedPreferences.getInstance();

          await SharedPref.setUserId(userIdToSet);
          final int? setUserId = pref.getInt('userId');

          expect(userIdToSet == setUserId, true);
        },
      );
      test(
        'if token is registered',
        () async {
          final isToken = await SharedPref.isTokenPresent();
          expect(isToken, true);
        },
      );
      test(
        'delete token from sharedPreference',
        () async {
          await SharedPref.deleteToken();
          final isToken = await SharedPref.isTokenPresent();
          expect(isToken, false);
        },
      );
      test(
        'clear all values from sharedPreferences',
        () async {
          SharedPreferences pref = await SharedPreferences.getInstance();

          SharedPref.clearAll();

          final isToken = await SharedPref.isTokenPresent();
          final isUserId = pref.containsKey('userId');

          expect(isToken, false);
          expect(isUserId, false);
        },
      );
    },
  );
}
