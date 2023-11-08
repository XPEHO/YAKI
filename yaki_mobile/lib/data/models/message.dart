import 'package:json_annotation/json_annotation.dart';

part "message.g.dart";

@JsonSerializable()
class Message {
  String message;

  Message({
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
