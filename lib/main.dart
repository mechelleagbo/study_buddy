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
  final List<_FeatureCard> _features = [
    _FeatureCard(
      title: 'Pomodoro Timer',
      icon: Icons.timer,
      color: Colors.redAccent,
      screen: PomodoroTimerPage(),
    ),
    _FeatureCard(
      title: 'Subjects & Tasks',
      icon: Icons.book,
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
      title: 'Progress Tracker',
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
      appBar: AppBar(
        title: Text('Study Buddy'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: _features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final feature = _features[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => feature.screen),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                color: feature.color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(feature.icon, size: 50, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      feature.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
