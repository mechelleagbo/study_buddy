import 'package:flutter/material.dart';

class SubjectListPage extends StatefulWidget {
  @override
  _SubjectListPageState createState() => _SubjectListPageState();
}

class _SubjectListPageState extends State<SubjectListPage> {
  Map<String, List<Task>> subjects = {};

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();

  void _addSubject() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Subject'),
        content: TextField(
          controller: _subjectController,
          decoration: InputDecoration(hintText: 'Enter subject name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _subjectController.clear();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_subjectController.text.trim().isNotEmpty) {
                setState(() {
                  subjects[_subjectController.text.trim()] = [];
                });
              }
              Navigator.pop(context);
              _subjectController.clear();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addTask(String subject) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task to $subject'),
        content: TextField(
          controller: _taskController,
          decoration: InputDecoration(hintText: 'Enter task name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _taskController.clear();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_taskController.text.trim().isNotEmpty) {
                setState(() {
                  subjects[subject]!
                      .add(Task(title: _taskController.text.trim()));
                });
              }
              Navigator.pop(context);
              _taskController.clear();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _deleteSubject(String subject) {
    setState(() {
      subjects.remove(subject);
    });
  }

  void _deleteTask(String subject, Task task) {
    setState(() {
      subjects[subject]!.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects & Tasks'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back to previous screen (dashboard)
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSubject,
        child: Icon(Icons.add),
        tooltip: 'Add Subject',
      ),
      body: subjects.isEmpty
          ? Center(
              child: Text(
                'No subjects added.\nTap + to add a subject',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView(
              padding: EdgeInsets.all(16),
              children: subjects.keys.map((subject) {
                final tasks = subjects[subject]!;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ExpansionTile(
                    title: Text(subject,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    children: [
                      if (tasks.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('No tasks added',
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ...tasks.map((task) => ListTile(
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (val) {
                                setState(() {
                                  task.isDone = val!;
                                });
                              },
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(subject, task),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.add),
                            label: Text('Add Task'),
                            onPressed: () => _addTask(subject),
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete Subject'),
                            onPressed: () => _deleteSubject(subject),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}
