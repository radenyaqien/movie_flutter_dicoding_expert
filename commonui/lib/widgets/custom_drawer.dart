import 'package:common/routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('movieflutter'),
            accountEmail: Text('movieflutter@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, homeMovieRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, watchListMovieRoute);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TV Shows'),
            onTap: () => Navigator.pushNamed(context, homeSeriesRoute),
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist Tv'),
            onTap: () {
              Navigator.pushNamed(context, watchListSeriesRoute);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, aboutRoute);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
