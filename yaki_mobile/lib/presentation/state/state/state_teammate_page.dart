import 'package:yaki/data/models/teammate_with_declaration_model.dart';

class StateTeamMate {
  List<TeammateWithDeclarationModel> fetchedTeammateList;
  List<TeammateWithDeclarationModel> selectedTeammateList;

  StateTeamMate({
    required this.fetchedTeammateList,
    required this.selectedTeammateList,
  });
}
