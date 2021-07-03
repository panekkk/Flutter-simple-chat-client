import 'package:chat_app/models/ChatUsers.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:chat_app/globals.dart' as globals;
import 'package:chat_app/broadcast.dart';

class ChatScreen extends StatefulWidget {
  final ChatUsers receiver;
  final ChatUsers sender;
  final Socket sock;
  @override
  _ChatScreenState createState() => _ChatScreenState();
  ChatScreen(Socket this.sock, this.receiver, this.sender);
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Chat z " + widget.receiver.name),
        ),
        body: Expanded(
        child: Stack(children: <Widget>[
          
             StreamBuilder(
              stream: Broadcast.broadcast,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int pos = globals.usersList.length - 1;
                  //String decoded = utf8.decode(snapshot.data as Uint8List);
                  // String token = decoded.substring(
                  //     decoded.indexOf('key') + 3, decoded.indexOf('.'));
                  // globals.usersList[pos].setToken(token);
                  print(snapshot.data);
                }
                return ListView.builder(
                  itemCount: widget.receiver.messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    if (widget.sender.messages.isNotEmpty) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (widget.receiver.messages[index].type ==
                                  "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (widget.sender.messages[index].type ==
                                      "receiver"
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              widget.sender.messages[index].content,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    } else
                      return Container();
                  },
                );
              },
            ),
          
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 70,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Form(
                        child: TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                              labelText: 'Send a message'),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: (_sendMessage),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 30,
                        ),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      ),
                    ],
                  ),
                )),
          
        ])));
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String sender = widget.sender.name;
      String receiver = widget.receiver.name;
      String token = widget.sender.token;
      String inputMessage = _controller.text;
      String message =
          "{'message':'$inputMessage', 'sender':'$sender',  'receiver':'$receiver', 'token':'$token'}";
      globals.usersList.add(new ChatUsers(sender));
      widget.sock.write(message);
    }
  }
}
