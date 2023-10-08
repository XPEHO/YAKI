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
