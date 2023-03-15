import 'package:json_annotation/json_annotation.dart';
part 'captain_model.g.dart';

@JsonSerializable()
class CaptainModel {
  int teamMateId;
  int teamMateTeamId;
  int teamMateUserId;
  int userId;
  String userLastName;
  String userFirstName;
  String userMail;
  String userLogin;
  String userPassword;

  CaptainModel({
    required this.teamMateId,
    required this.teamMateTeamId,
    required this.teamMateUserId,
    required this.userId,
    required this.userLastName,
    required this.userFirstName,
    required this.userMail,
    required this.userLogin,
    required this.userPassword,
  });

  factory CaptainModel.fromJson(Map<String, dynamic> json) =>
      _$CaptainModelFromJson(json);
  Map<String, dynamic> toJson() => _$CaptainModelToJson(this);
}
