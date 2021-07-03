import 'ChatMessage.dart';

class ChatUsers {
  ChatUsers(this.name);
  late String token;
  String name;
  List <ChatMessage> messages=[];
  void setToken(String t){
    this.token=t;
  }
}

