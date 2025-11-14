import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.purpleAccent,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Dark Mode"),
            value: false,
            onChanged: (val) {},
          ),
          ListTile(
            title: Text("Edit Profile"),
            trailing: Icon(Icons.person),
          ),
          ListTile(
            title: Text("About App"),
            trailing: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }
}
