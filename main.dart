import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/activity_log_screen.dart';
import 'screens/profile_screen.dart'; // Optional if you use profile navigation

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);

  runApp(FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case '/signup':
            return MaterialPageRoute(builder: (_) => SignupScreen());
          case '/activity_log':
            return MaterialPageRoute(builder: (_) => ActivityLogScreen());
          case '/home':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => HomeScreen(username: args['username']),
            );
          case '/profile':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => ProfileScreen(username: args['username']),
            );
          default:
            return MaterialPageRoute(builder: (_) => LoginScreen());
        }
      },
    );
  }
}