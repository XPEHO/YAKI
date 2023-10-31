import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/user.dart';
import 'package:yaki/data/sources/remote/user_api.dart';

class UserRepository {
  final UserApi userApi;

  UserRepository(
    this.userApi,
  );

  /// Retrieves information from the User API
  /// and stores the response in the userModel variable
  Future getUserById() async {
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
          final User userModel = setUserModel(userHttpResponse);
          print(userModel.toString());
          return userModel;
        default:
          throw Exception('Error while fetching user');
      }
    } catch (err) {
      throw Exception('Error while fetching user');
    }
  }

  ///Helper method that parses the API response data and returns a User object
  User setUserModel(HttpResponse response) {
    final User userModel = User.fromJson(response.data);
    return userModel;
  }
}
