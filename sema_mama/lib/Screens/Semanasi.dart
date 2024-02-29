import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sema_mama/Screens/users.dart';
import 'package:sema_mama/Screens/dashboard.dart';

class SemaNasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sema Mama'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(' YouTube Videos'),
            onTap: () {
              launch('https://www.youtube.com/channel/your_channel_id');
            },
          ),
          ListTile(
            title: Text('Our Location'),
            onTap: () {
              launch('https://maps.google.com/?q=your_location');
            },
          ),
          ListTile(
            title: Text('Sema Articles'),
            onTap: () {
              launch('https://your_sema_mama_articles_website.com');
            },
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
            child: const Text('Dashboard'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsersScreen()),
              );
            },
            child: const Text('Users'),
          ),
        ],
      ),
    );
  }
}
