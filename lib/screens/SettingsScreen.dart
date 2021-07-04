import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ustawienia'),
      ),
      body: ListView(
        children: const <Widget>[
          Card(
              child: ListTile(
            leading: Icon(Icons.import_export_rounded),
            title: Text("Eksportuj"),
          ))
        ],
      ),
    );
  }
}
