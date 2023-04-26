class DeclarationStatus {
  late String allDayDeclaration;
  late String morningDeclaration;
  late String afternoonDeclaration;

  DeclarationStatus();

  set statusAllDay(String status) {
    allDayDeclaration = status;
  }

  set statusMorning(String status) {
    morningDeclaration = status;
  }

  String get statusAllDay {
    return allDayDeclaration;
  }

  String get statusMorning {
    return morningDeclaration;
  }
}

const List<String> emptyDeclarationStatus = [""];
