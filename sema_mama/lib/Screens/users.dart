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
    'password': password,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    username: json['username'],
    email: json['email'],
    password: json['password'],
  );
}

class UserService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
      

  Future<void> addUser(User user) {
    return usersCollection
        .add(user.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<List<User>> getUsersAsStream() {
    var users = usersCollection.id;
    debugPrint('The User is $users');

    

    
    return usersCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data()as Map<String, dynamic>)).toList());
  }

  Future<void> updateUser(String id, User newUser) {
    return usersCollection
        .doc(id)
        .update(newUser.toJson())
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser(String id) {
    return usersCollection
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}

class UsersScreen extends StatelessWidget {
  final UserService _userService = UserService();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  UsersScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('User Management'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('All Users:'),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Column> usersWidgets = [];
                    if (snapshot.hasData) {
                      
                      final users = snapshot.data?.docs.reversed.toList();
                      
                      for (var user in users!) {
                        debugPrint('The Data Are $user');
                        // var email = user['email'];
                        // debugPrint('The Email is $email');
                        final usersWidget =  Column(
                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Text('Email: '),
                              Text(user['email']),
                            ],
                            ),

                            Row(children: [
                              const Text('Username: '),
                              Text(user['username']),
                            ],
                            ),

                            Row(children: [
                              const Text('Password: '),
                              Text(user['password']),
                            ],
                            ),
              
                            IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _editUser(context, user),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deleteUser(context, user),
                                ),
                            ],
                        );
                        usersWidgets.add(usersWidget);
                      }
                    }
                    return Expanded(
                      child: ListView(
                        
                        children: usersWidgets,
                        
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );

  void _editUser(BuildContext context, DocumentSnapshot userSnapshot) {
  Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

  if (userData != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController..text = userData['username'] ?? '',
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: emailController..text = userData['email'] ?? '',
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController..text = userData['password'] ?? '',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _userService.updateUser(userSnapshot.id, User(
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                ));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}


  void _deleteUser(BuildContext context, DocumentSnapshot user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _userService.deleteUser(user.id);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
