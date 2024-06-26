// ignore: file_names
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:semma_maam/Screens/dashboard.dart';
import 'package:semma_maam/Screens/userz.dart';



class SemaNasiPage extends StatelessWidget {
  const SemaNasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sema Mama'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(' YouTube Videos'),
            onTap: () {
              launch('https://www.youtube.com/channel/your_channel_id');
            },
          ),
          ListTile(
            title: const Text('Our Location'),
            onTap: () {
              launch('https://maps.google.com/?q=your_location');
            },
          ),
          ListTile(
            title: const Text('Sema Articles'),
            onTap: () {
              launch('https://your_sema_mama_articles_website.com');
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
  builder: (context) => DashboardScreen(
    settingsOnTap: () {
      // Function body for settingsOnTap
    },
    userProfileOnTap: () {
      // Function body for userProfileOnTap
    },
    reportsOnTap: () {
      // Function body for reportsOnTap
    },
  ),
)

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