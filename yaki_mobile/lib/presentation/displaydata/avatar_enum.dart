enum AvatarEnum {
  avatarH(
    "avatarH",
  ),
  avatarF(
    "avatarF",
  ),
  avatarN(
    "avatarN",
  ),
  avatarNone(
    "avatarNone",
  ),
  userPicture(
    "userPicture",
  )
  ;

  final String text;
  const AvatarEnum(this.text);

  /// return a list of all the .text of the enum
  static List<String> getPathList() {
    return AvatarEnum.values.map((e) => e.text).toList();
  }

  /// determine if the value passed as argument is equal to one of the .text of the enum.
  ///
  /// This determine if the path parameter passed in the url is valid
  static bool isValidPath({required String value}) {
    return AvatarEnum.getPathList().any((element) => element == value);
  }

  static AvatarEnum fromText(String textValue) {
    switch (textValue) {
      case 'avatarH':
        return AvatarEnum.avatarH;
      case 'avatarF':
        return AvatarEnum.avatarF;
      case 'avatarN':
        return AvatarEnum.avatarN;
      case 'userPicture':
        return AvatarEnum.userPicture;
      case 'avatarNone':
        return AvatarEnum.avatarNone;
      default:
        return AvatarEnum.avatarNone;
    }
  }
}
