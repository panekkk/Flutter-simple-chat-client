import 'package:chat_app/models/ChatMessage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'ChatMessage.dart';
part 'ChatUsers.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatUsers {
  ChatUsers( this.name,  this.messages);
  String name;
  List<ChatMessage> messages;
  factory ChatUsers.fromJson(Map<String, dynamic> json) => _$ChatUsersFromJson(json);
  Map<String, dynamic> toJson() => _$ChatUsersToJson(this);


}

