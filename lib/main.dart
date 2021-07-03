import 'package:flutter/material.dart';
import 'package:chat_app/screens/ContactsScreen.dart';
import 'dart:io';
void main() async{ 
  final Socket socket = await Socket.connect('192.168.33.103', 5000); 


  runApp(MyApp(socket));

}

class MyApp extends StatelessWidget {
  late final Socket sock;
  MyApp(Socket s) {
    this.sock = s;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat app',
      home:  ContactsScreen(sock),
    );
  }
  
}
