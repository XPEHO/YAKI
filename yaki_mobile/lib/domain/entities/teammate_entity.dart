class TeammateEntity {
  String? userFirstName;
  String? userLastName;
  DateTime? declarationDate;
  String? declarationStatus;
  List<String>? halfDayDeclarationStatus;

  TeammateEntity({
    required this.userFirstName,
    required this.userLastName,
    required this.declarationDate,
    this.declarationStatus,
  });

  addHalfDayDeclaration(String afternoonDeclaration) {
    halfDayDeclarationStatus = [declarationStatus!, afternoonDeclaration];
    declarationStatus = null;
  }

  // method override for unit test purpose,
  // allow to compare instance with == operator
  @override
  int get hashCode => Object.hash(
        userFirstName.hashCode,
        userLastName.hashCode,
        declarationDate.hashCode,
        declarationStatus.hashCode,
        halfDayDeclarationStatus.hashCode,
      );

  // method override for unit test purpose,
  // allow to compare instance with == operator
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TeammateEntity &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }
}
