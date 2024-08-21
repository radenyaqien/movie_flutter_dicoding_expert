import 'package:flutter/material.dart';
import 'package:movieflutter/presentation/pages/home_movie_page.dart';
import 'package:movieflutter/presentation/pages/series/watchlist_series_page.dart';

import '../pages/about_page.dart';
import '../pages/series/home_series_page.dart';
import '../pages/watchlist_movies_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, key});

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
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TV Shows'),
            onTap: () =>
                Navigator.pushNamed(context, HomeSeriesPage.ROUTE_NAME),
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist Tv'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
