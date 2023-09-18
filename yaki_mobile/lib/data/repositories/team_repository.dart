import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/sources/remote/team_api.dart';
import 'package:yaki/data/models/team_model.dart';

/// A repository class that retrieves data from the API and returns a list of
/// TeamEntity objects
class TeamRepository {
  final TeamApi teamApi;

  TeamRepository(
    this.teamApi,
  );

  /// Asynchronous method that retrieves a list of teams from the API and
  /// returns a list of TeamEntity objects
  Future<List<TeamModel>> getTeam() async {
    try {
      // Get userId stored in the sharedPreferences
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final int userId = pref.getInt('userId') ?? 0;
      // Send a GET request to the API to retrieve a list of teams
      final listHttpResponse = await teamApi.getTeam(userId);
      // Get the status code of the response
      final statusCode = listHttpResponse.response.statusCode;
      // Handle the response based on the status code
      switch (statusCode) {
        case 200:
          return setTeamModelList(listHttpResponse);
        default:
          // If the response status code is not 200, throw an exception
          throw Exception('Invalid statusCode : $statusCode');
      }
    } catch (err) {
      // Handle any errors that occur during the API request
      debugPrint('error during team list get : $err');
      return [];
    }
  }

  /// Helper method that parses the API response data and returns a list of
  /// TeamModel objects
  List<TeamModel> setTeamModelList(HttpResponse response) {
    final List<TeamModel> modelList = [];
    for (final team in response.data) {
      modelList.add(TeamModel.fromJson(team));
    }
    return modelList;
  }
}
