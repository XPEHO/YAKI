import 'package:yaki/domain/entities/declaration_status.dart';

///  Enum name match the json object's keys from assets/translations/*.json files format
///
///  Enum text match the status format to be send to the API.
enum StatusEnum {
  remote('remote'),
  onSite('on site'),
  vacation('vacation'),
  other('other'),
  halfDay('halfDay'),
  fullDay('fullDay'),
  morningTr('Morning'),
  afternoonTr('Afternoon');

  final String text;
  const StatusEnum(this.text);
}

/// status utilities
class StatusUtils {
  /// Reformat a string of words split with a defined character into camelCase
  ///
  /// ex : "Hello World" to "helloWorld".
  ///
  /// If the String to format is an empty string it will return '';
  ///
  /// If the splitCharacter is an empty string the String will be returned in lowerCase.
  static String toCamelCase({
    required String toFormat,
    required String splitChar,
  }) {
    // get out if either is empty string.
    if (toFormat.isEmpty) {
      return '';
    } else if (splitChar.isEmpty) {
      return toFormat.toLowerCase();
    }
    List<String> split = toFormat.split(splitChar);
    String formatted = split[0].toLowerCase();
    for (var i = 1; i < split.length; i++) {
      // first letter ([0]) capitalize + substring from string [1] in lowerCase.
      formatted +=
          split[i][0].toUpperCase() + split[i].substring(1).toLowerCase();
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
      } else {
        link = 'assets/images/$status.svg';
      }
    }
    return link;
  }

  /// Use status to create the translationKey value
  ///
  /// If status is an empty string, the default value will be used,
  /// and return the translationKey for the error message.
  static String getTranslationKey(String status, String mode) {
    String translationKey = "StatusError";
    String keyFormat = toCamelCase(toFormat: status, splitChar: ' ');

    if (status != emptyDeclarationStatus.first) {
      keyFormat = keyFormat[0].toUpperCase() + keyFormat.substring(1);
      translationKey = "status$keyFormat$mode";
    }
    return translationKey;
  }
}
