import 'package:flutter/material.dart';
import 'package:sema_mama/Screens/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sema_mama/Screens/users.dart';
import 'package:sema_mama/Screens/update.dart';
import 'package:sema_mama/Screens/delete.dart';


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
            title: Text('Sema_Articles'),
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
              child: const Text('Proceed To Dashboard'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersScreen()),
                );
              },
              child: const Text('See Users'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateScreen()),
                );
              },
              child: const Text('Go to update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteScreen()),
                );
              },
              child: const Text('Go to update'),
            ),              

          // You can add more ListTile widgets for additional links
        ],
      ),
    );
  }
}
