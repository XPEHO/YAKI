import 'package:yaki/data/models/team_mate_model.dart';
import 'package:yaki/data/sources/team_mate_api.dart';

class TeamMateRepository {
  final TeamMateApi _teamMateApi;

  TeamMateRepository(this._teamMateApi);

  Future<List<TeamMateModel?>> getTeamMate() async {
    final listTeamMateModel = await _teamMateApi.getTeamMate();
    return listTeamMateModel ;
  }

}