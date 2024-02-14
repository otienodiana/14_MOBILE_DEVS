import 'package:flutter/material.dart';
import 'Semanasi.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the screen
      appBar: AppBar(
        title: Text('SemaHome'), // App name in the app bar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'About Sema Mama',
              style: TextStyle(
                fontSize: 24.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Adjust the text color as needed
              ),
            ),
          ),
          SizedBox(height: 20.0), // Add some spacing
          Text(
            'Sema Mama is your go-to app for health and wellness.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 20.0), // Add some spacing
          ElevatedButton(
            onPressed: () {
              // Navigate to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SemaNasiPage()),
              );
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
