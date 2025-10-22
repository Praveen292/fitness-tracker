import 'package:flutter/material.dart';

class GoalTrackerScreen extends StatefulWidget {
  const GoalTrackerScreen({super.key});

  @override
  State<GoalTrackerScreen> createState() => _GoalTrackerScreenState();
}

class _GoalTrackerScreenState extends State<GoalTrackerScreen> {
  List<Map<String, dynamic>> goals = [
    {'title': 'Run 5km daily', 'completed': false},
    {'title': 'Burn 300 calories', 'completed': true},
    {'title': 'Walk 10,000 steps', 'completed': false},
  ];

  double get completionRate {
    final completed = goals.where((g) => g['completed'] == true).length;
    return completed / goals.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Goals'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        leading: const Icon(Icons.flag),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // 🔵 Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: completionRate,
                    backgroundColor: Colors.white24,
                    color: Colors.greenAccent,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(completionRate * 100).toStringAsFixed(0)}% Completed',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Goal List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  return Card(
                    color: Colors.white.withOpacity(0.1),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(
                        goal['completed'] ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: goal['completed'] ? Colors.greenAccent : Colors.white,
                      ),
                      title: Text(
                        goal['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          decoration: goal['completed'] ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: Switch(
                        value: goal['completed'],
                        activeColor: Colors.greenAccent,
                        onChanged: (val) {
                          setState(() {
                            goals[index]['completed'] = val;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}