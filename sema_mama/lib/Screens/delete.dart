import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  final String username;
  final String email;
  final String password;

  User({
    this.id = '',
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
      );
}

class DeleteScreen extends StatelessWidget {
  final String userId = 'fiu1o12OPW6idtpaKGBm'; // Adjust this with the actual user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: readUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final user =
              User.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username: ${user.username.isNotEmpty ? user.username : 'No Username'}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    deleteField(userId, 'username');
                  },
                  child: Text('Delete Username'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Email: ${user.email.isNotEmpty ? user.email : 'No Email Address'}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    deleteField(userId, 'email');
                  },
                  child: Text('Delete Email'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Password: ${user.password.isNotEmpty ? user.password : 'No Password'}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    deleteField(userId, 'password');
                  },
                  child: Text('Delete Password'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Stream<DocumentSnapshot> readUserDetails(String userId) =>
      FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

  Future<void> deleteField(String userId, String field) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        field: FieldValue.delete(),
      });
      print('$field deleted successfully');
    } catch (error) {
      print('Error deleting $field: $error');
    }
  }
}
