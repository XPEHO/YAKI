import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/state/state/team_page_state.dart';

enum LatestDeclarationStatus {
  unknown,
  declared,
  notDeclared,
}

class DeclarationStatus {
  late LatestDeclarationStatus latestDeclarationStatus =
      LatestDeclarationStatus.unknown;
  late TeamModel fullDayTeam = defaultTeam;
  late StatusEnum fullDayStatus = StatusEnum.undeclared;
  late HalfDayWorkflow halfDayWorkflow = HalfDayWorkflow();
  late DeclarationsHalfDaySelections declarationsHalfDaySelections =
      defaultHalfDay;
  late DateTime? dateAbsenceStart = DateTime.now().toUtc();
  late DateTime? dateAbsenceEnd = DateTime.now().toUtc();

  DeclarationStatus();

  DeclarationStatus copyWith({
    LatestDeclarationStatus? latestDeclarationStatus,
    TeamModel? fullDayTeam,
    StatusEnum? fullDayStatus,
    HalfDayWorkflow? halfDayWorkflow,
    DeclarationsHalfDaySelections? declarationsHalfDaySelections,
    DateTime? dateAbsenceStart,
    DateTime? dateAbsenceEnd,
    bool? isHalfDay,
    bool? isfullDay,
  }) {
    return DeclarationStatus()
      ..latestDeclarationStatus =
          latestDeclarationStatus ?? this.latestDeclarationStatus
      ..fullDayTeam = fullDayTeam ?? this.fullDayTeam
      ..fullDayStatus = fullDayStatus ?? this.fullDayStatus
      ..halfDayWorkflow = halfDayWorkflow ?? this.halfDayWorkflow
      ..declarationsHalfDaySelections =
          declarationsHalfDaySelections ?? this.declarationsHalfDaySelections
      ..dateAbsenceStart = dateAbsenceStart ?? this.dateAbsenceStart
      ..dateAbsenceEnd = dateAbsenceEnd ?? this.dateAbsenceEnd;
  }
}

class HalfDayWorkflow {
  late StatusEnum firstToDSelection;
  late TeamModel firstTeam;
  late TeamModel secondTeam;
  late StatusEnum firstStatus;
  late StatusEnum secondStatus;

  HalfDayWorkflow();
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
}

// DEFAULTS VALUES allow to use copyWith
TeamModel defaultTeam = TeamModel(
  teamId: absenceTeamId,
  teamName: "default",
  teamActifFlag: false,
);

// DEFAULTS VALUES  allow to use copyWith
DeclarationsHalfDaySelections defaultHalfDay = DeclarationsHalfDaySelections(
  morningTeam: defaultTeam,
  morningTeamStatus: StatusEnum.undeclared,
  afternoonTeam: defaultTeam,
  afternoonTeamStatus: StatusEnum.undeclared,
);
