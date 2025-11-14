import 'package:flutter/material.dart';
import 'screens/pomodoro_timer.dart';
import 'screens/subject_list.dart';
import 'screens/session_log.dart';
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
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final String username = "Hi, Student 👋";

  final List<_FeatureCard> _features = [
    _FeatureCard(
      title: 'Pomodoro',
      icon: Icons.timer,
      color: Colors.redAccent,
      screen: PomodoroTimerPage(),
    ),
    _FeatureCard(
      title: 'Subjects',
      icon: Icons.book_outlined,
      color: Colors.blueAccent,
      screen: SubjectListPage(),
    ),
    _FeatureCard(
      title: 'Session Log',
      icon: Icons.list_alt,
      color: Colors.orangeAccent,
      screen: SessionLogPage(),
    ),
    _FeatureCard(
      title: 'Progress',
      icon: Icons.show_chart,
      color: Colors.green,
      screen: ProgressTrackerPage(),
    ),
    _FeatureCard(
      title: 'Settings',
      icon: Icons.settings,
      color: Colors.purpleAccent,
      screen: SettingsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(height: 10),

            /// CENTERED PROFILE SECTION
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, size: 55, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Your Features",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            /// --- 2 buttons per row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFeatureButton(context, _features[0]),
                buildFeatureButton(context, _features[1]),
              ],
            ),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFeatureButton(context, _features[2]),
                buildFeatureButton(context, _features[3]),
              ],
            ),

            SizedBox(height: 16),

            /// LAST ONE CENTERED
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildFeatureButton(context, _features[4]),
              ],
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Button Builder
  Widget buildFeatureButton(BuildContext context, _FeatureCard feature) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => feature.screen),
        );
      },
      child: Container(
        width: 95,
        height: 95,
        decoration: BoxDecoration(
          color: feature.color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black26,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(feature.icon, size: 30, color: Colors.white),
            SizedBox(height: 6),
            Text(
              feature.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard {
  final String title;
  final IconData icon;
  final Color color;
  final Widget screen;

  _FeatureCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.screen,
  });
}
