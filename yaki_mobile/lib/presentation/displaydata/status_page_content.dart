import 'package:yaki/domain/entities/declaration_status.dart';

// StatusEnum.'values'.text is the json object's keys from assets/translations/*.json files
// StatusEnum.values.byName('remote') = StatusEnum.remote
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

String reformatOnSite(String status) {
  String statusFormat = status;
  if (status == 'on site') {
    // on site to onSite
    statusFormat = status.split(" ")[0] + status.split(" ")[1][0].toUpperCase() + status.split(" ")[1].substring(1);
  }
  return statusFormat;
}

/// Create image link from declaration status string value.
///
/// If status = "", it will return the "unknown" image ( error situation )
///
/// If not empty string compare status with enum.text.
///
/// And the enum.name will determine which image name will be used and display.
String getStatusImage(String status) {
  String link = 'assets/images/unknown.svg';

  if (status.toLowerCase() == StatusEnum.other.text.toLowerCase()) {
    link = 'assets/images/dots.svg';
  } else if (status != emptyDeclarationStatus) {
    String key = StatusEnum.values.byName(status).name.toLowerCase();
    link = 'assets/images/$key.svg';
  }
  return link;
}

/// Create status message translationKey from declaration status string
///
/// If status = "", it will return the StatusError message.
///
/// If not empty string, reformat enum.name to uppercase the first letter.
///
/// ( remove _ from ON_SITE if its the selected status )
///
/// Which will be aggregated to "Status" to create the translationKey.
String getStatusTranslationKey(String status) {
  String translationKey = "StatusError";

  if (status != emptyDeclarationStatus) {
    String value = status;

    if (status == StatusEnum.onSite.text) {
      value = status.replaceAll(RegExp(' '), '');
    }
    String name = StatusEnum.values.byName(value.toLowerCase()).name;
    String key = name[0].toUpperCase() + name.substring(1);
    translationKey = "Status$key";
  }
  return translationKey;
}
