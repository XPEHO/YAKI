import 'package:yaki/domain/entities/declaration_status.dart';

// StatusEnum.'values'.text is the json object's keys from assets/translations/*.json files
// StatusEnum.values.byName('key') = StatusEnum.key
enum StatusEnum {
  //enum.values.name(enum.values.text),
  //String(String)
  remote('remote'),
  onSite('on site'),
  vacation('vacation'),
  other('other');

  final String text;
  const StatusEnum(this.text);
}


class StatusUtils {
  /// reformat a string, split with a defined character into, camelCase
  ///
  /// ex : "Hello World" to "helloWorld".
  static String toCamelCase({required String toFormat, required String splitChar}) {
    // get out if either is empty string.
    if (toFormat.isEmpty) {
      return '';
    } else if (splitChar.isEmpty) {
      return toFormat.toLowerCase();
    }
    List<String> split = toFormat.split(splitChar);
    String formatted = split[0].toLowerCase();
    for(var i = 1; i < split.length; i++) {
      // first letter ([0]) capitalize + substring from string [1] in lowerCase.
      formatted += split[i][0].toUpperCase() + split[i].substring(1).toLowerCase();
    }
    return formatted;
  }


  static String getImage(String status) {
    String link = 'assets/images/unknown.svg';
    String keyFormat = StatusUtils.toCamelCase(toFormat: status, splitChar: ' ');

    if (status != emptyDeclarationStatus) {
      if (keyFormat == StatusEnum.other.name) {
        link = 'assets/images/dots.svg';
      } else {
        String key = StatusEnum.values.byName(keyFormat).name;
        link = 'assets/images/$key.svg';
      }
    }
    return link;
  }


  static String getTranslationKey(String status) {
    String translationKey = "StatusError";
    String keyFormat = StatusUtils.toCamelCase(toFormat: status, splitChar: ' ');

    if (status != emptyDeclarationStatus) {
      keyFormat = keyFormat[0].toUpperCase() + keyFormat.substring(1);
      translationKey = "Status$keyFormat";
    }
    return translationKey;
  }
}


