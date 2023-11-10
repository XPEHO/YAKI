import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/models/message.dart';
import 'package:yaki/data/sources/remote/avatar_api.dart';
import 'package:yaki/domain/entities/avatar_entity.dart';

class AvatarRepository {
  final AvatarApi avatarApi;

  AvatarRepository(
    this.avatarApi,
  );

  Future<AvatarEntity> postAvatarById({
    required String avatarReference,
    File? avatar,
  }) async {
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

    var avatarJson = AvatarEntity(
      avatarReference: null,
      avatar: null,
    );

    try {
      final avatarHttpResponse =
          await avatarApi.postAvatarById(userId, formData);
      final statusCode = avatarHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          //response is an map, therefore a string
          if (avatarHttpResponse.data is Map<String, dynamic>) {
            final message = Message.fromJson(avatarHttpResponse.data);
            avatarJson = AvatarEntity(
              avatarReference: message.message,
              avatar: null,
            );
            return avatarJson;
            // response is a List, therefore an byte array, so an image
          } else if (avatarHttpResponse.data is List<dynamic>) {
            List<dynamic> rawData = avatarHttpResponse.data;
            Uint8List imageData = Uint8List.fromList(rawData.cast<int>());

            avatarJson = AvatarEntity(
              avatarReference: null,
              avatar: imageData,
            );
            return avatarJson;
          }
        default:
          'Error while posting avatar : ${jsonDecode(avatarHttpResponse.data)['message']}';
      }
      return avatarJson;
    } catch (err) {
      throw Exception('Error while posting avatar : $err');
    }
  }

  /// Retrieves information from the Avatar API
  /// and stores the response in the avatarModel variable

  Future<AvatarEntity> getAvatarById() async {
    var avatarJson = AvatarEntity(
      avatarReference: null,
      avatar: null,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");
    if (userId == null) {
      debugPrint("error while fetching avatar : no userid found");
      return avatarJson;
    }

    try {
      final avatarHttpResponse = await avatarApi.getAvatarById(userId);
      final statusCode = avatarHttpResponse.response.statusCode;

      switch (statusCode) {
        case 200:
          if (avatarHttpResponse.data is Map<String, dynamic>) {
            final message = Message.fromJson(avatarHttpResponse.data);
            avatarJson = AvatarEntity(
              avatarReference: message.message,
              avatar: null,
            );
            return avatarJson;
          } else if (avatarHttpResponse.data is List<dynamic>) {
            List<dynamic> rawData = avatarHttpResponse.data;
            Uint8List imageData = Uint8List.fromList(rawData.cast<int>());

            avatarJson = AvatarEntity(
              avatarReference: null,
              avatar: imageData,
            );
            return avatarJson;
          }
        case 404: // no avatar found
          return avatarJson;
        default:
          throw Exception(
            'Error while fetching avatar : ${jsonDecode(avatarHttpResponse.data)['message']}',
          );
      }
    } catch (err) {
      debugPrint("error while fetching avatar : $err");
    }

    return avatarJson;
  }
}
