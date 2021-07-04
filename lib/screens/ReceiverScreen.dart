import 'package:chat_app/models/ChatUsers.dart';
import 'package:chat_app/screens/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/ContactsScreen.dart';
import 'package:chat_app/screens/SettingsScreen.dart';
import 'dart:io';
import 'package:chat_app/globals.dart' as globals;

class ReceiverScreen extends StatefulWidget {
  late final Socket sock;
  late final ChatUsers sender;
  ReceiverScreen(Socket s, ChatUsers c) {
    this.sock = s;
    this.sender = c;
  }
  @override
  _ReceiverScreenState createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {
  Widget build(BuildContext context) {
    final List<ChatUsers> receivers = List.from(globals.usersList);
    receivers.remove(widget.sender);
    return Scaffold(
        appBar: AppBar(
          title: Text('Z kim chcesz porozmawiać? '),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: receivers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.account_circle_rounded),
                      title: Text(receivers[index].name),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(widget.sock,
                                    receivers[index], widget.sender)));
                      },
                    );
                  }),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "button2",
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactsScreen(
                          widget.sock,
                        ),
                      ));
                },
                child: Icon(Icons.navigate_before),
              ),
              FloatingActionButton(
                heroTag: "button1",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                child: Icon(
                  Icons.settings,
                  size: 30,
                ),
                backgroundColor: Colors.grey,
              )   
            ],
          ),
        ));
  }
}
