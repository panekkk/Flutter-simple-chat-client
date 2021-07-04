import 'package:chat_app/screens/ChatScreen.dart';
import 'package:chat_app/screens/ReceiverScreen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/SettingsScreen.dart';
import 'RegisterScreen.dart';
import 'dart:io';
import 'package:chat_app/globals.dart' as globals;

class ContactsScreen extends StatefulWidget {
  late Socket sock;
  ContactsScreen(Socket s) {
    this.sock = s;
  }
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista użytkowników'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: globals.usersList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.account_circle_rounded),
                      title: Text(globals.usersList[index].name),
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReceiverScreen(
                              widget.sock, globals.usersList[index]);
                        }));
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
                heroTag: "button1",
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen(widget.sock)));
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
                backgroundColor: Colors.grey,
              ),
              FloatingActionButton(
                heroTag: "button2",
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
