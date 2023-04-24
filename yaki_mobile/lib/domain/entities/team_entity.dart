class TeamEntity {
  int? teamId;
  String? teamName;

  TeamEntity({
    required this.teamId,
    required this.teamName,
  });
  @override
  int get hashCode => Object.hash(
        teamId.hashCode,
        teamName.hashCode,
      );

  // method override for unit test purpose,
  // allow to compare instance with == operator
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TeamEntity &&
            runtimeType == other.runtimeType &&
            hashCode == other.hashCode;
  }
}
