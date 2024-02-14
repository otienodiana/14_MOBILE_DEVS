import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Your Dashboard!',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: () {
                // Add your action here
              },
              child: Text('Button 1'),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              onPressed: () {
                // Add your action here
              },
              child: Text('Button 2'),
            ),
            // Add more buttons or widgets as needed
          ],
        ),
      ),
    );
  }
}
