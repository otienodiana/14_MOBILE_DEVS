import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    // Your web app's Firebase configuration
    // Initialize Firebase
    Firebase.initializeApp(
      options: const FirebaseOptions(
        // Replace these values with your Firebase project's configuration
        apiKey: 'AIzaSyBXs0c2eWALZRIftqgqXt4wW_CMPEPxef4',
        authDomain: 'sema-mama-f365d.web.app',
        projectId: 'sema-mama-f365d', appId: '1:582818276388:android:771c82c467ba7675e9a4b1', messagingSenderId: '582818276388',
      ),
    );
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
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();

      final UserCredential userCredential =
          await auth.signInWithPopup(googleProvider);

      Provider.of<ValueNotifier<UserCredential?>>(
        context,
        listen: false,
      ).value = userCredential;
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
      Provider.of<ValueNotifier<UserCredential?>>(
        context,
        listen: false,
      ).value = null;
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
