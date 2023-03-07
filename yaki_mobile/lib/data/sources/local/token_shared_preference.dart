import 'package:shared_preferences/shared_preferences.dart';

void addTokenToSF(String? token) async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 prefs.setString('token', token!);

}
