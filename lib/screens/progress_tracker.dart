import 'package:flutter/material.dart';

class ProgressTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Tracker"),
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          "Progress charts and statistics coming soon.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
