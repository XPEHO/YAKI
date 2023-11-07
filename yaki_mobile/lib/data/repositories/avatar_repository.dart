import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/sources/remote/avatar_api.dart';

class AvatarRepository {
  final AvatarApi avatarApi;

  AvatarRepository(
    this.avatarApi,
  );

  Future<void> postAvatarById({
    required String avatarReference,
    File? avatar,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt("userId");
      if (userId == null) {
        throw Exception('invalid user');
      }

      var formData = FormData.fromMap({
        'avatarName': avatarReference,
        'avatar':
            avatar == null ? null : await MultipartFile.fromFile(avatar.path),
      });

      final avatarHttpResponse =
          await avatarApi.postAvatarById(userId, formData);
      final statusCode = avatarHttpResponse.response.statusCode;
      final contentType = avatarHttpResponse.response.headers['content-type'];

      debugPrint(contentType.toString());

      switch (statusCode) {
        case 200:
          debugPrint("post avatar success");
          if (contentType!.contains('charset=utf-8')) {
            // Handle string response
            debugPrint(avatarHttpResponse.response.data);
          } else if (contentType.contains('octet-stream')) {
            // Handle image response
            Uint8List bytes = avatarHttpResponse.response.data;
            Image image = Image.memory(bytes);
            print(image);
          }
        default:
          throw Exception('Error while fetching avatar');
      }
    } catch (err) {
      throw Exception('Error while fetching avatar');
    }
  }

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
}
