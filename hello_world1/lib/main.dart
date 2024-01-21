import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              '14_MOBILE DEVS ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
          shadowColor: Color.fromARGB(31, 224, 216, 216),
          backgroundColor: Color.fromARGB(255, 43, 31, 175),
          elevation: 0.0,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        body: const Center(
          child: Text(
            'Hello World!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 8, 11),
      ),
    );
  }
}