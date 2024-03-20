import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                      ElevatedButton(
                        onPressed: () async {
                          await _signOutFromGoogle(context);
                        },
                        child: const Text('Logout'),
                      ),
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
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() {
          _userCredential.value = userCredential;
        });
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

  Future<void> _signOutFromGoogle(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        _userCredential.value = null;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign out')),
      );
    }
  }
}
