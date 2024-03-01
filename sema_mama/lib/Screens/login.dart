import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:sema_mama/Screens/signup.dart';
import './home.dart'; // Import the home page
// Import the signup page

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                // Store the email input
                // You can perform validation here if needed
              },
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (value) {
                // Store the password input
                // You can perform validation here if needed
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Perform login action
                _login(context);
              },
              child: const Text('Login'),
            ),
             Row(
              children: [
                const Text('Dont have an account?',
            ),
            TextButton(
              
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SignupScreen()),
                );
              },
              child: const Text('Signup'),
            ),
            ],)
          ],
        ),
      ),
    );
  }

  // Function to handle login
  void _login(BuildContext context) async {
    try {
      // Sign in with email and password

      // User login successful, navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      if (e.code == 'user-not-found') {
        // User does not exist, navigate to signup screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()));
        
      } else if (e.code == 'wrong-password') {
        // Incorrect password
        if (kDebugMode) {
          print('Incorrect password');
        }
        // Show error message to the user if needed
      } else {
        // Other errors
        if (kDebugMode) {
          print('Error: ${e.message}');
        }
        // Show error message to the user if needed
      }
    } catch (e) {
      // Handle other errors
      if (kDebugMode) {
        print('Error: $e');
      }
      // Show error message to the user if needed
    }
  }
}

