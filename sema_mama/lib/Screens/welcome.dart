import 'package:flutter/material.dart';
import 'package:sema_mama/Screens/login.dart';
import 'signup.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo or Image
            Image.asset(
              'assets/Black background maternity image.jpeg',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'Wellcome',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            // App Slogan or Tagline
            const Text(
              'Your Health Companion for life',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            // Next Button
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}