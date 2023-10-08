import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

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
