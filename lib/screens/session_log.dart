import 'package:flutter/material.dart';

class SessionLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session Log"),
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Text(
          "Your study sessions will appear here.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
