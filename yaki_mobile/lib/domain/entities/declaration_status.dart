import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';

class DeclarationStatus {
  late TeamModel fullDayTeam;
  late StatusEnum fullDayStatus;
  late HalfDayWorkflow halfDayWorkflow = HalfDayWorkflow();
  late DeclarationsHalfDaySelections declarationsHalfDaySelections;
  late DateTime? dateAbsenceStart;
  late DateTime? dateAbsenceEnd;
  bool isHalfDay = false;
  bool isfullDay = false;

  DeclarationStatus();

  get absenceStatus => null;

  get dateStart => null;

  get dateEnd => null;
}

class HalfDayWorkflow {
  late StatusEnum firstToDSelection;
  late TeamModel firstTeam;
  late TeamModel secondTeam;
  late StatusEnum firstStatus;
  late StatusEnum secondStatus;

  HalfDayWorkflow();

  @override
  String toString() {
    return 'HalfDayWorkflow{firstToDSelection: $firstToDSelection, firstTeam: ${firstTeam.teamName}, secondTeam: ${secondTeam.teamName}, firstStatus: $firstStatus, secondStatus: $secondStatus}';
  }
}

class DeclarationsHalfDaySelections {
  TeamModel morningTeam;
  StatusEnum morningTeamStatus;
  TeamModel afternoonTeam;
  StatusEnum afternoonTeamStatus;

  DeclarationsHalfDaySelections({
    required this.morningTeam,
    required this.morningTeamStatus,
    required this.afternoonTeam,
    required this.afternoonTeamStatus,
  });

  @override
  String toString() {
    return 'DeclarationsHalfDaySelections{morningTeam: ${morningTeam.teamName}, morningTeamStatus: $morningTeamStatus, afternoonTeam: ${afternoonTeam.teamName}, afternoonTeamStatus: $afternoonTeamStatus}';
  }
}
