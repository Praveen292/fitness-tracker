import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'MobApp is a fitness tracker built using Flutter and Firebase.\n\n'
              'Track your workouts, log your activity, and stay motivated.\n\n'
              'Created by Praveen for academic and personal growth.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}