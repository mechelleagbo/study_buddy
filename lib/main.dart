import 'package:flutter/material.dart';
import 'screens/pomodoro_timer.dart';
import 'screens/subject_list.dart';
import 'screens/progress_tracker.dart';
import 'screens/settings_page.dart';

void main() {
  runApp(StudyBuddyApp());
}

class StudyBuddyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(202, 225, 225, 225),
      ),
      home: DashboardWrapper(),
    );
  }
}

class DashboardWrapper extends StatefulWidget {
  @override
  _DashboardWrapperState createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    SubjectListPage(),
    ProgressTrackerPage(),
    PomodoroTimerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: "Subjects"),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
        ],
      ),
    );
  }
}

/// ====================== DASHBOARD ===============================

class DashboardScreen extends StatelessWidget {
  final String username = "Hi, Mechelle 👋";

  final List<Map<String, dynamic>> subjects = [
    {"title": "Math Homework", "done": false},
    {"title": "Science Project", "done": true},
    {"title": "Flutter App Task", "done": false},
    {"title": "History Notes", "done": false},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pending =
        subjects.where((s) => s["done"] == false).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          "Study Buddy",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
        ],
      ),

      /// ================= MINIMAL DRAWER + NEW MENU ITEMS ======================
      drawer: Drawer(
        width: 90,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 50),

              /// New menu items
              _drawerIcon(context, Icons.calendar_today,
                  PlaceholderPage("Study Planner")),
              _drawerIcon(context, Icons.palette,
                  PlaceholderPage("Appearance / Theme")),
              _drawerIcon(
                  context, Icons.backup, PlaceholderPage("Data & Backup")),
              _drawerIcon(context, Icons.help_outline,
                  PlaceholderPage("Help & Support")),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Color.fromARGB(255, 106, 135, 203),
                    child: Icon(Icons.person, size: 65, color: Colors.black54),
                  ),
                  SizedBox(height: 15),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Text(
                  "Reminders",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                if (pending.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${pending.length}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: pending.isEmpty
                  ? Center(
                      child: Text(
                        "🎉 All tasks completed! Great job!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: pending.map((task) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Icon(Icons.circle,
                                  size: 10, color: Colors.redAccent),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  task["title"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "“Small progress is still progress. Keep going!” 💪",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Drawer Icon Widget
  Widget _drawerIcon(BuildContext context, IconData icon, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: GestureDetector(
        child: Icon(icon, size: 32, color: Colors.black87),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }
}

/// Placeholder pages for new menu items
class PlaceholderPage extends StatelessWidget {
  final String title;
  PlaceholderPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Text(
          "$title Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
