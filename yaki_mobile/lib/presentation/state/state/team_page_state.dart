import 'package:yaki/data/models/team_model.dart';

class TeamPageState {
  List<TeamModel> selectedTeamList;
  bool isButtonActivated;

  TeamPageState({
    required this.selectedTeamList,
    required this.isButtonActivated,
  });
}
