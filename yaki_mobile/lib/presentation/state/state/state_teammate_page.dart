import 'package:yaki/data/models/teammate_with_declaration_model.dart';

class StateTeammate {
  List<TeammateWithDeclarationModel> fetchedTeammateList;
  List<TeammateWithDeclarationModel> selectedTeammateList;

  StateTeammate({
    required this.fetchedTeammateList,
    required this.selectedTeammateList,
  });
}
