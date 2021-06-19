import 'package:json_annotation/json_annotation.dart';
part 'ChatMessage.g.dart';

@JsonSerializable()
class ChatMessage {
   String content;
   String type;
  DateTime time;
 // static final DateTime now = DateTime.now();
 // final String currentDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
  ChatMessage(this.content, this.type,this.time);

  factory ChatMessage.fromJson(Map<String,dynamic>json) =>
    _$ChatMessageFromJson(json);
    Map<String,dynamic> toJson()=> _$ChatMessageToJson(this);
}
