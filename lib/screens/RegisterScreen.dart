import 'dart:convert';
import 'dart:typed_data';

import 'package:chat_app/models/ChatUsers.dart';
import 'package:chat_app/screens/ContactsScreen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:chat_app/globals.dart' as globals;
import 'package:chat_app/broadcast.dart';

// Define a custom Form widget.
class RegisterScreen extends StatefulWidget {
  late final Socket channel;
  RegisterScreen(Socket s) {
    this.channel = s;
  }

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late ChatUsers user;
  final TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
    if (!Broadcast.isSet) {
      Broadcast.broadcast = widget.channel.asBroadcastStream();
      Broadcast.isSet=true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Zarejestruj się"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                child: TextFormField(
                  controller: _controller,
                  decoration:
                      const InputDecoration(labelText: 'Zarejestruj użytkownika'),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: Broadcast.broadcast,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int pos = globals.usersList.length - 1;
                      String decoded = utf8.decode(snapshot.data as Uint8List);
                      String token = decoded.substring(
                          decoded.indexOf('key') + 3, decoded.indexOf('.'));
                      globals.usersList[pos].setToken(token);
                      print(globals.usersList[pos].name +
                          globals.usersList[pos].token);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                          snapshot.hasData ? snapshot.data.toString() : ''),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "button1",
                onPressed: (_sendMessage),
                child: Icon(Icons.send),
              ),
              FloatingActionButton(
                heroTag: "button2",
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactsScreen(
                          widget.channel,
                        ),
                      ));
                },
                child: Icon(Icons.navigate_next),
              )
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String sender = _controller.text;
      String registrationMessage = "{'register':'true', 'sender':'$sender'}";
      globals.usersList.add(new ChatUsers(sender));
      widget.channel.write(registrationMessage);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
