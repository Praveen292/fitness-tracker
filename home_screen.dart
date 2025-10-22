import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'profile_screen.dart';
import 'goal_tracker_screen.dart';
import 'workoutscreen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int calories = 0;
  int heartRate = 0;

  @override
  void initState() {
    super.initState();
    fetchUserStats();
  }

  Future<void> fetchUserStats() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.username)
          .get();

      if (doc.exists) {
        final data = doc.data();
        setState(() {
          calories = data?['calories'] ?? 0;
          heartRate = data?['heartRate'] ?? 0;
        });
      }
    } catch (e) {
      print('Error fetching stats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final greeting = 'Good Morning, ${widget.username}!';

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Stay active. Stay healthy.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      spacing: 20,
                      children: [
                        CircleIcon(
                          label: 'Profile',
                          icon: Icons.person,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/profile',
                              arguments: {'username': widget.username},
                            );
                          },
                        ),
                        CircleIcon(
                          label: 'Workout',
                          icon: Icons.fitness_center,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutScreen(
                                  heartRate: heartRate,
                                  calories: calories,
                                ),
                              ),
                            );
                          },
                        ),
                        const CircleIcon(label: 'Food', icon: Icons.restaurant),
                        const CircleIcon(label: 'Settings', icon: Icons.settings),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          label: '$calories kcal',
                          icon: Icons.local_fire_department,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: StatCard(
                          label: '$heartRate bpm',
                          icon: Icons.favorite,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        minimumSize: const Size(double.infinity, 55),
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.flag, size: 28),
                      label: const Text(
                        'Track Your Goals',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GoalTrackerScreen()),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to activity log screen
                    },
                    child: const Text('See Activity Log', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupScreen()),
                            );
                          },
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to About screen
                      },
                      child: const Text('About', style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final IconData icon;
  const StatCard({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orangeAccent, size: 32),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  const CircleIcon({required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}