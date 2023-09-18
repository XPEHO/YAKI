import 'package:yaki/data/models/team_model.dart';

class TeamPageState {
  List<TeamModel> selectedTeamList;
  bool isValidationActivated;

  TeamPageState({
    required this.selectedTeamList,
    required this.isValidationActivated,
  });
}
