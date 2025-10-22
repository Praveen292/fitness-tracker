import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String goals = '';
  int calories = 0;
  int heartRate = 0;
  bool _obscurePassword = true;

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(username);
        final snapshot = await userDoc.get();

        if (snapshot.exists) {
          showMessage('Username already exists');
        } else {
          await userDoc.set({
            'username': username,
            'password': password,
            'email': username,
            'goals': goals,
            'calories': calories,
            'heartRate': heartRate,
          });

          showMessage('Account created!');
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {'username': username},
          );
        }
      } catch (e) {
        showMessage('Signup failed: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Username
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onSaved: (value) => username = value!,
                    validator: (value) => value!.isEmpty ? 'Enter username' : null,
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextFormField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    onSaved: (value) => password = value!,
                    validator: (value) => value!.length < 4 ? 'Password too short' : null,
                  ),
                  const SizedBox(height: 20),

                  // Goals
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Your Fitness Goal (e.g. Run 5km daily)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onSaved: (value) => goals = value!,
                    validator: (value) => value!.isEmpty ? 'Enter your goal' : null,
                  ),
                  const SizedBox(height: 20),

                  // Calories
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Calories Burned',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onSaved: (value) => calories = int.tryParse(value!) ?? 0,
                    validator: (value) => value!.isEmpty ? 'Enter calories' : null,
                  ),
                  const SizedBox(height: 20),

                  // Heart Rate
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Heart Rate (bpm)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onSaved: (value) => heartRate = int.tryParse(value!) ?? 0,
                    validator: (value) => value!.isEmpty ? 'Enter heart rate' : null,
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: signup,
                    child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 20),

                  // Login Link
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}