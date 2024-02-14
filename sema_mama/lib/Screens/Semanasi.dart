import 'package:flutter/material.dart';


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
            title: Text('Watch our YouTube Videos'),
            onTap: () {
              launch('https://www.youtube.com/channel/your_channel_id');
            },
          ),
          ListTile(
            title: Text('Find us on Google Maps'),
            onTap: () {
              launch('https://maps.google.com/?q=your_location');
            },
          ),
          ListTile(
            title: Text('Read Articles on Sema Mama'),
            onTap: () {
              launch('https://your_sema_mama_articles_website.com');
            },
          ),
          // You can add more ListTile widgets for additional links
        ],
      ),
    );
  }
}
