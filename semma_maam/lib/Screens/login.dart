import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semma_maam/Screens/signup.dart';
import './home.dart';


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
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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

  Future<void> _signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '582818276388-5nrk1q9k0qr1cbgain8m6hlcrpi3tns1.apps.googleusercontent.com',
    );
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        // ignore: prefer_typing_uninitialized_variables
        var userCredential0;
        userCredential0.value = userCredential;
      });
    }
  } catch (e) {
    // Error handling if
    if (kDebugMode) {
      print('Exception: $e');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to sign in with Google')),
    );
  }
}




Future<void> setState(Null Function() param0) async {
  try {
    // Perform asynchronous operation here
    // For example, fetching data from a network call
    // or performing some computation

    // Once the asynchronous operation is complete,
    // update the state and rebuild the UI

    // Example:
    // await fetchData();
    // setState(() {
    //   // Update state variables here
    // });
  } catch (e) {
    // Handle any errors that occur during the asynchronous operation
    print('Error occurred: $e');
  }
}
}