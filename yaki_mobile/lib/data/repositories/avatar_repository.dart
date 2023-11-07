import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/avatar.dart';
import 'package:yaki/data/sources/remote/avatar_api.dart';

class AvatarRepository {
  final AvatarApi avatarApi;

  AvatarRepository(
    this.avatarApi,
  );

  /// Retrieves information from the Avatar API
  /// and stores the response in the avatarModel variable
  
  // Future<Avatar> getAvatarById() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final int? userId = prefs.getInt("userId");
  //     if (userId == null) {
  //       throw Exception('invalid avatar');
  //     }

  //     final avatarHttpResponse = await avatarApi.getAvatarById(userId);
  //     final statusCode = avatarHttpResponse.response.statusCode;

  //     switch (statusCode) {
  //       case 200:
  //         final avatarJson = avatarHttpResponse.response.data.first;

  //         final Avatar avatar = Avatar(
  //           avatarId: avatarJson['avatar_id'],
  //           avatarUserId: avatarJson['avatar_userId'],
  //           avatarReference: avatarJson['avatar_reference'],
  //           avatarBlob: avatarJson['avatar_blob'],
  //           avatarIsValidated: avatarJson['avatar_isValidated'],
  //         );

  //         return avatar;
  //       default:
  //         throw Exception('Error while fetching avatar');
  //     }
  //   } catch (err) {
  //     throw Exception('Error while fetching avatar');
  //   }
  // }


  Future<Avatar> postAvatarById() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt("userId");
      if (userId == null) {
        throw Exception('invalid avatar');
      }

      final avatarHttpResponse = await avatarApi.postAvatarById(userId, {
        "avatar_userId": userId,
        "avatar_reference": "avatar_reference",
        "avatar_file": "avatar_file",
      });
      final statusCode = avatarHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          final avatarJson = avatarHttpResponse.response.data.first;

          final Avatar avatar = Avatar(
            avatarUserId: avatarJson['avatar_userId'],
            avatarReference: avatarJson['avatar_reference'],
            avatarFile: avatarJson['avatar_file'],
          );

          return avatar;
        default:
          throw Exception('Error while fetching avatar');
      }
    } catch (err) {
      throw Exception('Error while fetching avatar');
    }
  }


}
