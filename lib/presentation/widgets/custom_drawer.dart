import 'package:flutter/material.dart';
import 'package:movieflutter/presentation/pages/home_movie_page.dart';
import 'package:movieflutter/presentation/pages/series/watchlist_series_page.dart';

import '../pages/about_page.dart';
import '../pages/series/home_series_page.dart';
import '../pages/watchlist_movies_page.dart';

class CustomDrawer extends StatelessWidget {
   CustomDrawer({key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('movieflutter'),
            accountEmail: Text('movieflutter@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('TV Shows'),
            onTap: () => Navigator.pushNamed(context, HomeSeriesPage.ROUTE_NAME),
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist Tv'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
