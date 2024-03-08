import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sema_mama/Screens/signup.dart';
import './home.dart';
import './google_sign_in.dart'; // Import the GoogleSignInScreen

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

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
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _loginWithEmailPassword(context);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _signInWithGoogle(context);
              },
              child: const Text('Sign in with Google'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _loginWithEmailPassword(BuildContext context) async {
    try {

      // User login successful, navigate to home screen
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      if (e.code == 'user-not-found') {
        // User does not exist, navigate to signup screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
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

  void _signInWithGoogle(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GoogleSignInScreen()),
    );
  }
}
