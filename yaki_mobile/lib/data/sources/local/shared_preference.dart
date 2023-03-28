import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /// Save token received after user authentication in the sharedPreference.
  /// the token value is associated to the 'token' key.
  /// Use Future<Void> for testing purpose.
  static Future<void> setToken(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // !token, use null check, if login error..
    prefs.setString('token', token!);
  }

  static Future<void> setUserId(int? id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', id!);
  }

  /// check if sharedPreference has a token, return a true or false depending.
  static Future<bool> isTokenPresent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

// Future<void> return is necessary to be inoked with 'await'
  static Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static void clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
