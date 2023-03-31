import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /// Save token, retrieve in loginRepository.userAuthentication() method, in the sharedPreference.
  /// the token value is associated to the 'token' key.
  /// Use Future<Void> for testing purpose and invoke the method with the await keyword.
  static Future<void> setToken(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // !token, use null check, if login error..
    prefs.setString('token', token!);
  }

  /// Save the userId retrieve in loginRepository.userAuthentication() method, in the sharedPreference
  /// The userid value is associated with the 'userId' key.
  /// Use Future<Void> for testing purpose and invoke the method with the await keyword.
  static Future<void> setUserId(int? id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', id!);
  }

  /// check if sharedPreference has a token, using containsKey() methode, return true or false depending.
  static Future<bool> isTokenPresent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  /// Check if a token is saved in the sharedPreference, if so, deleteIt.
  /// Future<void> return is necessary to be inoked with 'await'
  static Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await SharedPref.isTokenPresent()) {
      await prefs.remove('token');
    }
  }

  /// Clear all values saved in sharedPreference
  static void clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
