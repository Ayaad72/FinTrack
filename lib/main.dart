import 'package:flutter/material.dart';
import 'models/screens/login_screens.dart';
import 'models/screens/dashboard_screen.dart';
import 'models/utils/local_storage.dart';
import 'theme/app_theme.dart'; // 👈 Import your theme file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Check if the user is logged in from local storage
    final loggedIn = await LocalStorage.isLoggedIn();
    runApp(SpendWiseApp(startOnDashboard: loggedIn == true));
  } catch (e) {
    // If there's any error, start with login screen
    runApp(const SpendWiseApp(startOnDashboard: false));
  }
}

class SpendWiseApp extends StatelessWidget {
  final bool startOnDashboard;

  const SpendWiseApp({super.key, required this.startOnDashboard});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // 👈 Apply elegant white theme
      home: startOnDashboard ? const DashboardScreen() : const LoginScreen(),
    );
  }
}
