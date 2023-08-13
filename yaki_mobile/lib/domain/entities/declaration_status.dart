class DeclarationStatus {
  late String fullDayDeclaration;
  late String morningDeclaration;
  late String afternoonDeclaration;

  DeclarationStatus();

  set statusFullDay(String status) {
    fullDayDeclaration = status;
  }

  set statusMorning(String status) {
    morningDeclaration = status;
  }

  String get statusFullDay {
    return fullDayDeclaration;
  }

  String get statusMorning {
    return morningDeclaration;
  }
}

const List<String> emptyDeclarationStatus = [""];
