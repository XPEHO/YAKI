import 'package:yaki/domain/entities/declaration_status.dart';

///  Enum name (keys) match the json object's keys from assets/translations/*.json files format
///
///  Enum text (values) match the status format to be send to the API.
enum StatusEnum {
  remote('remote'),
  onSite('on site'),
  vacation('vacation'),
  other('other'),
  halfDay('halfDay'),
  fullDay('fullDay'),
  morningTr('Morning'),
  afternoonTr('Afternoon'),
  undeclared('undeclared');

  final String value;
  const StatusEnum(this.value);

  static String getValue({required String key}) {
    return StatusEnum.values.byName(key).value;
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

  /// Use status to create the image relative link.
  ///
  /// If status is an empty string the default value will be used, and display
  /// the selected 'error' image.
  static String getImage(String status) {
    String link = 'assets/images/unknown.svg';

    if (status != emptyDeclarationStatus.first) {
      if (status == StatusEnum.other.name) {
        link = 'assets/images/dots.svg';
      } else if (status == StatusEnum.undeclared.name) {
        link = 'assets/images/unknown.svg';
      } else {
        link = 'assets/images/$status.svg';
      }
    }

    return link;
  }

  /// Use status to create the translationKey value
  ///
  /// If status is an empty string, the translationKey for the error message will be returned.
  static String getTranslationKey(String status, String mode) {
    String translationKey = "StatusError";
    String keyFormat = toCamelCase(toFormat: status);

    if (status != emptyDeclarationStatus.first) {
      keyFormat = keyFormat[0].toUpperCase() + keyFormat.substring(1);
      translationKey = "status$keyFormat$mode";
    }
    return translationKey;
  }
}