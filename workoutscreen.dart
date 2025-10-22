import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  final int heartRate;
  final int calories;

  const WorkoutScreen({super.key, required this.heartRate, required this.calories});

  List<String> getWorkoutSuggestions() {
    if (heartRate < 70 && calories < 100) {
      return ['Warm-up Walk', 'Stretching Routine', 'Light Yoga'];
    } else if (heartRate < 100 && calories < 300) {
      return ['Jogging 20 mins', 'Bodyweight Circuit', 'Dance Cardio'];
    } else {
      return ['HIIT Session', 'Strength Training', 'Advanced Cardio Burn'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final workouts = getWorkoutSuggestions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Workout Plan'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        leading: const Icon(Icons.fitness_center),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6E7F), Color(0xFFBFE9FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Based on your stats:',
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              '❤️ Heart Rate: $heartRate bpm   🔥 Calories: $calories kcal',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // 🏋️ Suggested Workouts
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.fitness_center, color: Colors.white, size: 28),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            workouts[index],
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
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