import 'package:shared_preferences/shared_preferences.dart';

/// Save token received after user authentication in the sharedPreference.
/// the token value is associated to the 'token' key.
void addTokenToSharedPreference(String? token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // !token, use null check, if login error.
  prefs.setString('token', token!);
}

void addUserIdToSharedPreference(int? id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('userId', id!);
}

/// check if sharedPreference has a token, return a true or false depending.
Future<bool> isTokenPresent() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('token');
}

Future<void> removeTokenFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}
