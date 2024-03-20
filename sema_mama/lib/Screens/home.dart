import 'package:flutter/material.dart';
import 'Semanasi.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white, // Background color of the screen
      appBar: AppBar(
        title: const Text('SemaHome'), // App name in the app bar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'About Sema Mama',
              style: TextStyle(
                fontSize: 24.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Adjust the text color as needed
              ),
            ),
          ),
          const SizedBox(height: 20.0), // Add some spacing
          const Text(
            'Sema Mama is your go-to app for health and wellness.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20.0), // Add some spacing
          ElevatedButton(
            onPressed: () {
              // Navigate to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SemaNasiPage()),
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
