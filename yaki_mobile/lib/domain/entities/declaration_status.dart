class DeclarationStatus {
  late String fullDayStatus = "";
  late String morningStatus = "";
  late String afternoonStatus = "";
  late DateTime? dateStart;
  late DateTime? dateEnd;

  DeclarationStatus();

  @override
  String toString() {
    return 'DeclarationStatus{fullDayStatus: $fullDayStatus, morningStatus: $morningStatus, afternoonStatus: $afternoonStatus}';
  }
}

const List<String> emptyDeclarationStatus = [""];
