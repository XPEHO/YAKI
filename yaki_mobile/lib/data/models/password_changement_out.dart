import 'package:json_annotation/json_annotation.dart';

part 'password_changement_out.g.dart';

@JsonSerializable()
class PasswordChangementOut {
  int userId;
  String currentPassword;
  String newPassword;

  PasswordChangementOut({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
  });

  factory PasswordChangementOut.fromJson(Map<String, dynamic> json) =>
      _$PasswordChangementOutFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordChangementOutToJson(this);
}
