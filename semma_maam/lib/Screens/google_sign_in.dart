import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semma_maam/Screens/home.dart';


class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  late ValueNotifier<UserCredential?> _userCredential;

  @override
  void initState() {
    super.initState();
    _userCredential = ValueNotifier<UserCredential?>(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google SignIn Screen')),
      body: Center(
        child: ValueListenableBuilder<UserCredential?>(
          valueListenable: _userCredential,
          builder: (context, userCredential, child) {
            return userCredential == null
                ? ElevatedButton(
                    onPressed: () async {
                      await _signInWithGoogle(context);
                    },
                    child: const Text('Sign In with Google'),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userCredential.user!.displayName ?? ''),
                      const SizedBox(height: 10),
                      Text(userCredential.user!.email ?? ''),
                      const SizedBox(height: 20),
                      
                    ],
                  );
          },
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      // ignore: unused_local_variable
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // After successful sign-in, navigate to SemaNasiPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  } catch (e) {
    // Error handling
    if (kDebugMode) {
      print('Exception: $e');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to sign in with Google')),
    );
  }
}
}