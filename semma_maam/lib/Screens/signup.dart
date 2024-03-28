import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class SignupScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  SignupScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign Up for Your App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                final username = usernameController.text.trim();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                createUser(context: context, username: username, email: email, password: password);
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createUser({required BuildContext context, required String username, required String email, required String password}) async {
    try {
      // Create user authentication
      // ignore: unused_local_variable
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Reference to document
      final docUser = FirebaseFirestore.instance.collection('users').doc(email); // Using email as document ID

      final json = {
        'username': username,
        'email' : email,
        'password' : password,
        // Avoid storing password in Firestore for security reasons
      };

      // Write user data to Firestore
      await docUser.set(json);

      // Handle successful creation
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      // Handle errors
      print("Error creating user: $e");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error creating user: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
