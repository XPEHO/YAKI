enum DeclarationTimeOfDay { morning, afternoon, fullDay }

enum DeclarationPaths {
  fullDay('full-day'),
  timeOfDay('time-of-day'),
  halfDayStart('half-day-start'),
  halfDayEnd('half-day-end'),
  vacation('vacation');

  final String text;
  const DeclarationPaths(this.text);

  /// return a list of all the .text of the enum
  static List<String> getPathList() {
    return DeclarationPaths.values.map((e) => e.text).toList();
  }

  /// determine if the value passed as argument is equal to one of the .text of the enum.
  ///
  /// This determine if the path parameter passed in the url is valid
  static bool isValidPath({required String value}) {
    return DeclarationPaths.getPathList().any((element) => element == value);
  }

  static DeclarationPaths? fromText(String textValue) {
    switch (textValue) {
      case 'full-day':
        return DeclarationPaths.fullDay;
      case 'time-of-day':
        return DeclarationPaths.timeOfDay;
      case 'half-day-start':
        return DeclarationPaths.halfDayStart;
      case 'half-day-end':
        return DeclarationPaths.halfDayEnd;
      case 'vacation':
        return DeclarationPaths.vacation;
      default:
        return null;
    }
  }
}
