import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class User {
  String id;
  final String username;
  final String email;
  final String password;

  User({
    this.id='',
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    username: json['username'],
    email: json['email'],
    password: json['password'],
  );
}
class UpdateScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'Update',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),

          ElevatedButton(
            child: Text('Update'),
            onPressed: () async {
              try {
                final username = usernameController.text;
                final email = emailController.text;
                final password = passwordController.text;
                final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc();

                await docUser.update({
                  'username': username,
                  'email': email,
                  'password': password,
                });
              } catch (error) {
                print('Error updating document: $error');
              }
            },
            
          ),

        ],
      )
    ),
  );
  Widget buildUser(User user) => ListTile(
      leading: CircleAvatar(child:Text('${user.username}')),
      title: Text(user.email),
      subtitle: Text(user.username),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
    .collection('users')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
    
  Future<void> updateUser({ required String username, required String email, required String password}) async {
  try {
    final docUser = FirebaseFirestore.instance.collection('users').doc(password);

    final json = {
      'username': username,
      'email': email,
      'password': password,
    };

    await docUser.update(json);
    print('User updated successfully');
  } catch (error) {
    print('Error updating user: $error');
  }
}
}