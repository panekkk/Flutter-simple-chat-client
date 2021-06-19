import 'package:chat_app/screens/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/ChatUsers.dart';
import 'package:chat_app/screens/SettingsScreen.dart';
import 'dart:convert';
import 'package:flutter/services.dart';


class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List  chatUsers =[];
 
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/users.json');
    final data = await jsonDecode(response)["users"];
    setState(() {
      chatUsers = data.map((dane)=>ChatUsers.fromJson(dane)).toList();
    });
  }

@override
void initState() {
  super.initState();
  this.readJson();
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista użytkowników'),
      ),
      body: ListView.builder(
          itemCount: chatUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text(chatUsers[index].name),
              subtitle: Text("Ostatnia wiadomość: ${chatUsers[index].messages.last.time}"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen(chatUsers[index])));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=>SettingsScreen()));
        },
        child: Icon(
          Icons.settings,
          size: 30,
        ),
        backgroundColor: Colors.grey,
      ),
      
    );
  }
}
