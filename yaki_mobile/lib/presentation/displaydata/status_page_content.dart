// StatusEnum.'values'.text is the json object's keys from assets/translations/*.json files
// StatusEnum.values.byName('remote') = StatusEnum.remote
// StatusEnum.remote.name = remote (type : String)
// StatusEnum.remote.text = REMOTE (type : String)
import 'package:yaki/domain/entities/declaration_status.dart';

enum Status {
  //enum.values.name(enum.values.text),
  //String(String)
  remote('REMOTE'),
  onsite('ON_SITE'),
  vacation('VACATION'),
  other('OTHER');

  final String text;
  const Status(this.text);
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

  if (status == Status.other.text) {
    link = 'assets/images/dots.svg';
  } else if (status != emptyDeclarationStatus) {
    String key = Status.values.byName(status).name;
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

    if (status == Status.onsite.text) {
      value = status.replaceAll(RegExp('_'), '');
    }
    String name = Status.values.byName(value.toLowerCase()).name;
    String key = name[0].toUpperCase() + name.substring(1);
    translationKey = "Status$key";
  }
  return translationKey;
}
