import 'package:json_annotation/json_annotation.dart';

part 'password_forgot_out.g.dart';

@JsonSerializable()
class PasswordForgotOut {
  String email;

  PasswordForgotOut({
    required this.email,
  });

  factory PasswordForgotOut.fromJson(Map<String, dynamic> json) =>
      _$PasswordForgotOutFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordForgotOutToJson(this);
}
