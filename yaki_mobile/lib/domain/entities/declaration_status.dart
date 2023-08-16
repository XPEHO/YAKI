class DeclarationStatus {
  late String fullDayStatus = "";
  late String morningStatus = "";
  late String afternoonStatus = "";

  DeclarationStatus();

  @override
  String toString() {
    return 'DeclarationStatus{fullDayStatus: $fullDayStatus, morningStatus: $morningStatus, afternoonStatus: $afternoonStatus}';
  }
}

const List<String> emptyDeclarationStatus = [""];
