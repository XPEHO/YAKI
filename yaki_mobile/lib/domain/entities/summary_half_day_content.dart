import 'package:yaki/data/models/team_model.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

class SummaryHalfDayContent {
  final TeamModel morningTeam;
  final StatusEnum morningStatus;
  final TeamModel afternoonTeam;
  final StatusEnum afternoonStatus;

  const SummaryHalfDayContent({
    required this.morningTeam,
    required this.morningStatus,
    required this.afternoonTeam,
    required this.afternoonStatus,
  });
}
