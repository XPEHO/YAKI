enum AvatarEnum {
  avatarH("assets/images/avatar-men.svg"),
  avatarF("assets/images/avatar-woman.svg"),
  avatarN("assets/images/Avatar.svg"),
  avatarNone(""),
  userPicture("");

  final String text;
  const AvatarEnum(this.text);

  static List<String> defaultAvatarList() {
    return AvatarEnum.values
        .where(
          (element) =>
              element != AvatarEnum.avatarNone &&
              element != AvatarEnum.userPicture,
        )
        .map((e) => e.name)
        .toList();
  }

  static final List<String> defaultAvatars = defaultAvatarList();
}
