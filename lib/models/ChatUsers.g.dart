// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatUsers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUsers _$ChatUsersFromJson(Map<String, dynamic> json) {
  return ChatUsers(
    json['name'] as String,
    (json['messages'] as List<dynamic>)
        .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ChatUsersToJson(ChatUsers instance) => <String, dynamic>{
      'name': instance.name,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };
