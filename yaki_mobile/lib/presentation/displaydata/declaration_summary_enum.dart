enum DeclarationSummaryPaths {
  fullDay('full-day'),
  halfDay('half-day'),
  absence('absence');

  final String text;
  const DeclarationSummaryPaths(this.text);

  /// return a list of all the .text of the enum
  static List<String> getPathList() {
    return DeclarationSummaryPaths.values.map((e) => e.text).toList();
  }

  /// determine if the value passed as argument is equal to one of the .text of the enum.
  ///
  /// This determine if the path parameter passed in the url is valid
  static bool isValidPath({required String value}) {
    return DeclarationSummaryPaths.getPathList()
        .any((element) => element == value);
  }
}
