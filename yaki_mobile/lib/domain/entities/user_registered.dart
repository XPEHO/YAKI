import 'package:json_annotation/json_annotation.dart';

part 'user_registered.g.dart';

@JsonSerializable()
class UserRegistered {
  final bool isRegistered;

  UserRegistered({required this.isRegistered});

  factory UserRegistered.fromJson(Map<String, dynamic> json) =>
      _$UserRegisteredFromJson(json);
  Map<String, dynamic> toJson() => _$UserRegisteredToJson(this);
}
