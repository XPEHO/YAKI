import 'dart:typed_data';

class TeamLogoEntity {
  int teamId;
  Uint8List teamLogo;

  TeamLogoEntity({
    required this.teamId,
    required this.teamLogo,
  });
}
