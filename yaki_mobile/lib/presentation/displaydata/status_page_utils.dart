///  Enum name (keys) match the json object's keys from assets/translations/*.json files format
///
///  Enum text (values) match the status format to be send to the API.
enum StatusEnum {
  remote('remote'),
  onSite('on site'),
  absence('absence'),
  halfDay('halfDay'),
  fullDay('fullDay'),
  morning('Morning'),
  afternoon('Afternoon'),
  undeclared('undeclared');

  final String value;
  const StatusEnum(this.value);

  static String getValue({required String key}) {
    return StatusEnum.values.byName(key).value;
  }

  static StatusEnum fromValue(String textValue) {
    switch (textValue) {
      case 'remote':
        return StatusEnum.remote;
      case 'on site':
        return StatusEnum.onSite;
      case 'absence':
        return StatusEnum.absence;
      default:
        return StatusEnum.undeclared;
    }
  }
}

/// status utilities
class StatusUtils {
  // regexp checking for any no letter characters, so number and any special characters, space included
  static final RegExp _specialCharacter = RegExp(r'[^a-zA-Z]+');

  /// Reformat a string of words split with specials character (space includes) or number, into camelCase
  ///
  /// ex : "Hello World" to "helloWorld".
  ///
  /// If the String to format is an empty string, an empty string will be returned;
  ///
  /// If the string only has letter, the String to formats will be returned in lowerCase.
  static String toCamelCase({
    required String toFormat,
  }) {
    // get out if either is empty string.
    if (toFormat.isEmpty) {
      return '';
    } else if (!_specialCharacter.hasMatch(toFormat)) {
      return toFormat.toLowerCase();
    }
    //this will split the string at each special character position
    List<String> splited = toFormat.split(_specialCharacter);
    String formatted = splited[0].toLowerCase();

    for (var i = 1; i < splited.length; i++) {
      // first letter ([0]) capitalize + substring from string [1] in lowerCase.
      formatted +=
          splited[i][0].toUpperCase() + splited[i].substring(1).toLowerCase();
    }
    return formatted;
  }
}
