import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users {
  String id;
  final String username;
  final String email;
  final String password;

  Users({
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

  static Users fromJson(Map<String, dynamic> json) => Users(
    username: json['username'],
    email: json['email'],
    password: json['password'],
  );
}

class UserService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
      

  Future<void> addUser(Users user) {
    return usersCollection
        .add(user.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<List<Users>> getUsersAsStream() {
    var users = usersCollection.id;
    debugPrint('The User is $users');

    

    
    return usersCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Users.fromJson(doc.data()as Map<String, dynamic>)).toList());
  }

  Future<void> updateUser(String id, Users newUser) {
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