import 'package:yaki/data/models/team_model.dart';

class TeamPageState {
  List<TeamModel> fetchedTeamList;
  List<TeamModel> selectedTeamList;
  bool isButtonActivated;

  TeamPageState({
    required this.fetchedTeamList,
    required this.selectedTeamList,
    required this.isButtonActivated,
  });

  get teamName => null;
}
