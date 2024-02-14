import 'package:flutter/material.dart';
import 'package:sema_mama/Screens/signup.dart';

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
              'assets/sema_mama_logo.png', // Replace 'assets/sema_mama_logo.png' with the path to your app logo
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            // App Name
            Text(
              'Sema Mama',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            // App Slogan or Tagline
            Text(
              'Your Health Companion',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 30),
            // Next Button
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text('Welcome Onboard'),
            ),
          ],
        ),
      ),
    );
  }
}
