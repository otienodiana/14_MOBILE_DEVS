import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'update.dart';

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
class UsersScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
          final users = snapshot.data!;

            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UsersScreen(),
            ));
        }
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
    
  Future createUser({required String username, required String email, required String password}) async {
   ///Reference to document
   final docUser = FirebaseFirestore.instance.collection('users').doc();

   final json = {
     'username': username,
     'email' : email,
     'password' : password,
   };

   ///Create document and write data to Firebase
   await docUser.set(json);
  }
}
