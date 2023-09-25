import 'package:yaki/presentation/displaydata/status_page_utils.dart';

class DeclarationStatus {
  late String fullDayStatus = "";
  late DeclarationTeamsInfo teamsHalfDay = DeclarationTeamsInfo();
  late DateTime? dateStart;
  late DateTime? dateEnd;

  DeclarationStatus();
}

const List<String> emptyDeclarationStatus = [""];

class DeclarationTeamsInfo {
  late StatusEnum firstToDSelection = StatusEnum.morning;
  late int firstTeamId = 0;
  late int secondTeamId = 0;
  late String firstTeamStatus = "";
  late String secondTeamStatus = "";

  DeclarationTeamsInfo();
}
