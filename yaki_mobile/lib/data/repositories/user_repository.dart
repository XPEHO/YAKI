import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/user_info_profile.dart';
import 'package:yaki/data/sources/remote/user_api.dart';

class UserRepository {
  final UserApi userApi;

  UserRepository(
    this.userApi,
  );

  /// Retrieves information from the User API
  /// and stores the response in the userModel variable
  Future<UserInfoProfile> getUserById() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt("userId");
      if (userId == null) {
        throw Exception('invalid user');
      }

      final userHttpResponse = await userApi.getUserById(userId);
      final statusCode = userHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          final userJson = userHttpResponse.response.data.first;

          final UserInfoProfile user = UserInfoProfile(
            lastName: userJson['user_last_name'],
            firstName: userJson['user_first_name'],
            email: userJson['user_email'],
          );

          return user;
        default:
          throw Exception('Error while fetching user');
      }
    } catch (err) {
      throw Exception('Error while fetching user');
    }
  }
}
