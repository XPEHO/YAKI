class DeclarationEntityIn {
  final List<int> teamIdList;
  final List<String> fullDayStatus;
  final DateTime? dateStart;
  final DateTime? dateEnd;

  DeclarationEntityIn({
    required this.teamIdList,
    required this.dateStart,
    required this.dateEnd,
    required this.fullDayStatus,
  });
}
