class TeamMateEntity {
  String? userFirstName;
  String? userLastName;
  DateTime? declarationDate;
  String? declarationStatus;

  TeamMateEntity({
    required this.userFirstName,
    required this.userLastName,
    required this.declarationDate,
    required this.declarationStatus,
  });

  // method override for unit test purpose,
  // allow to compare instance with == operator
  @override
  int get hashCode => Object.hash(
        userFirstName.hashCode,
        userLastName.hashCode,
        declarationDate.hashCode,
        declarationStatus.hashCode,
      );

  // method override for unit test purpose,
  // allow to compare instance with == operator
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TeamMateEntity &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }
}
