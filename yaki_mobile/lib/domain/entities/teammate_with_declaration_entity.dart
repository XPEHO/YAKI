import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

class TeammateWithDeclarationEntity {
  int loggedUserId;
  int userId;
  String? userFirstName;
  String? userLastName;
  DateTime declarationDate;
  DateTime declarationDateStart;
  DateTime? declarationDateEnd;
  StatusEnum declarationStatus;
  int teamId;
  String teamName;
  StatusEnum? declarationStatusAfternoon;
  int? teamIdAfternoon;
  String? teamNameAfternoon;
  int declarationId;
  int declarationUserId;

  TeammateWithDeclarationEntity({
    required this.loggedUserId,
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.declarationDate,
    required this.declarationDateStart,
    required this.declarationDateEnd,
    required this.declarationStatus,
    required this.teamId,
    required this.teamName,
    this.declarationStatusAfternoon,
    this.teamIdAfternoon,
    this.teamNameAfternoon,
    required this.declarationId,
    required this.declarationUserId,
  });

  // method override for unit test purpose,
  // allow to compare instance with == operator
  @override
  int get hashCode => Object.hash(
        loggedUserId.hashCode,
        userFirstName.hashCode,
        userLastName.hashCode,
        declarationDate.hashCode,
        declarationStatus.hashCode,
        teamId.hashCode,
        teamName.hashCode,
        declarationStatusAfternoon.hashCode,
        teamIdAfternoon.hashCode,
        teamNameAfternoon.hashCode,
        declarationId.hashCode,
        declarationUserId.hashCode,
      );

  // method override for unit test purpose,
  // allow to compare instance with == operator
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TeammateWithDeclarationEntity &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }
}
