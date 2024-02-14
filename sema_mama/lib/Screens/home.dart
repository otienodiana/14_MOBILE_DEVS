import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the screen
      appBar: AppBar(
        title: Text('Sema Mama'), // App name in the app bar
      ),
      body: Center(
        child: Text(
          'Welcome to Sema Mama',
          style: TextStyle(
            fontSize: 24.0, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Adjust the text color as needed
          ),
        ),
      ),
    );
  }
}
