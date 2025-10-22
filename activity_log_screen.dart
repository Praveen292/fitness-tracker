import 'package:flutter/material.dart';

class ActivityLogScreen extends StatelessWidget {
  final List<Map<String, dynamic>> activityLog = [
    {'date': '2025-09-20', 'steps': 5000, 'calories': 200},
    {'date': '2025-09-19', 'steps': 7000, 'calories': 250},
    {'date': '2025-09-18', 'steps': 4000, 'calories': 180},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Log'),
      ),
      body: ListView.builder(
        itemCount: activityLog.length,
        itemBuilder: (context, index) {
          final log = activityLog[index];
          return Card(
            child: ListTile(
              title: Text('Date: ${log['date']}'),
              subtitle: Text('Steps: ${log['steps']}  Calories: ${log['calories']}'),
            ),
          );
        },
      ),
    );
  }
}