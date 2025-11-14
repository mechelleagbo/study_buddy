import 'package:flutter/material.dart';

class SubjectListPage extends StatefulWidget {
  @override
  _SubjectListPageState createState() => _SubjectListPageState();
}

class _SubjectListPageState extends State<SubjectListPage> {
  List<Map<String, dynamic>> subjects = [];

  TextEditingController subjectNameController = TextEditingController();
  TextEditingController taskController = TextEditingController();

  void addSubjectDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Subject"),
        content: TextField(
          controller: subjectNameController,
          decoration: InputDecoration(labelText: "Subject Name"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (subjectNameController.text.isNotEmpty) {
                setState(() {
                  subjects
                      .add({"name": subjectNameController.text, "tasks": []});
                });
                subjectNameController.clear();
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void addTaskDialog(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Task for ${subjects[index]['name']}"),
        content: TextField(
          controller: taskController,
          decoration: InputDecoration(labelText: "Task"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                setState(() {
                  subjects[index]["tasks"].add(taskController.text);
                });
                taskController.clear();
                Navigator.pop(context);
              }
            },
            child: Text("Add Task"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addSubjectDialog,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
      body: subjects.isEmpty
          ? Center(
              child: Text(
                "No subjects yet.\nTap + to add one.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ExpansionTile(
                    title: Text(
                      subjects[index]["name"],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ...subjects[index]["tasks"].map<Widget>((t) {
                        return ListTile(
                          title: Text(t),
                        );
                      }).toList(),
                      TextButton(
                        onPressed: () => addTaskDialog(index),
                        child: Text("Add Task"),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
