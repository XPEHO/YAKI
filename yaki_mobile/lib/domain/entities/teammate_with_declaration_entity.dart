import 'dart:typed_data';

import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';

class TeammateWithDeclarationEntity {
  int loggedUserId;
  int userId;
  String userFirstName;
  String userLastName;
  DateTime? declarationDate;
  DateTime? declarationDateStart;
  DateTime? declarationDateEnd;
  StatusEnum declarationStatus;
  int? teamId;
  String? teamName;
  int? customerId;
  String? customerName;
  StatusEnum? declarationStatusAfternoon;
  int? teamIdAfternoon;
  String? teamNameAfternoon;
  int? customerAfternoonId;
  String? customerAfternoonName;
  String? avatarReference;
  Uint8List? avatar;

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
    required this.customerId,
    required this.customerName,
    this.declarationStatusAfternoon,
    this.teamIdAfternoon,
    this.teamNameAfternoon,
    this.customerAfternoonId,
    this.customerAfternoonName,
    required this.avatarReference,
    required this.avatar,
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
        customerId.hashCode,
        customerName.hashCode,
        declarationStatusAfternoon.hashCode,
        teamIdAfternoon.hashCode,
        teamNameAfternoon.hashCode,
        customerAfternoonId.hashCode,
        customerAfternoonName.hashCode,
        avatarReference.hashCode,
        avatar.hashCode,
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

  @override
  String toString() {
    return "{loggedUserId: $loggedUserId, userId: $userId, userFirstName: $userFirstName, userLastName: $userLastName, avatarReference: $avatarReference, avatar: $avatar";
  }
}
