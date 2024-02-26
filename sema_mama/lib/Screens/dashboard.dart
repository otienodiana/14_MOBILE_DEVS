import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey),
                ),
              ),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('UserProfile'),
                    leading: Icon(Icons.dashboard),
                    onTap: () {
                      
                    },
                  ),
                  ListTile(
                    title: Text('Reports'),
                    leading: Icon(Icons.bar_chart),
                    onTap: () {
                      
                    },
                  ),
                  ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to Your Dashboard',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
