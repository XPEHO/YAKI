import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';

class DeclarationStatus {
  late TeamModel fullDayTeam;
  late StatusEnum fullDayStatus;
  late DeclarationTeamsInfo teamsHalfDay = DeclarationTeamsInfo();
  late DateTime? dateStart;
  late DateTime? dateEnd;

  DeclarationStatus();
}

const List<String> emptyDeclarationStatus = [""];

class DeclarationTeamsInfo {
  late StatusEnum firstToDSelection = StatusEnum.morning;
  late TeamModel firstTeam;
  late TeamModel secondTeam;
  late StatusEnum firstStatus;
  late StatusEnum secondStatus;

  DeclarationTeamsInfo();

  @override
  String toString() {
    return 'DeclarationTeamsInfo{firstToDSelection: $firstToDSelection, firstTeam: ${firstTeam.teamName}, secondTeam: ${secondTeam.teamName}, firstStatus: $firstStatus, secondStatus: $secondStatus}';
  }
}
