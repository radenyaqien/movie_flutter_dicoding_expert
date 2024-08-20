import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieflutter/common/constants.dart';
import 'package:movieflutter/common/utils.dart';
import 'package:movieflutter/injection.dart' as di;
import 'package:movieflutter/presentation/pages/about_page.dart';
import 'package:movieflutter/presentation/pages/home_movie_page.dart';
import 'package:movieflutter/presentation/pages/movie_detail_page.dart';
import 'package:movieflutter/presentation/pages/popular_movies_page.dart';
import 'package:movieflutter/presentation/pages/search_page.dart';
import 'package:movieflutter/presentation/pages/series/home_series_page.dart';
import 'package:movieflutter/presentation/pages/series/popular_series_page.dart';
import 'package:movieflutter/presentation/pages/series/search_series_page.dart';
import 'package:movieflutter/presentation/pages/series/series_detail_page.dart';
import 'package:movieflutter/presentation/pages/series/top_rated_series_page.dart';
import 'package:movieflutter/presentation/pages/series/watchlist_series_page.dart';
import 'package:movieflutter/presentation/pages/top_rated_movies_page.dart';
import 'package:movieflutter/presentation/pages/watchlist_movies_page.dart';
import 'package:movieflutter/presentation/provider/movie_detail_notifier.dart';
import 'package:movieflutter/presentation/provider/movie_list_notifier.dart';
import 'package:movieflutter/presentation/provider/movie_search_notifier.dart';
import 'package:movieflutter/presentation/provider/popular_movies_notifier.dart';
import 'package:movieflutter/presentation/provider/series/popular_series_notifier.dart';
import 'package:movieflutter/presentation/provider/series/series_detail_notifier.dart';
import 'package:movieflutter/presentation/provider/series/series_list_notifier.dart';
import 'package:movieflutter/presentation/provider/series/series_search_notifier.dart';
import 'package:movieflutter/presentation/provider/series/top_rated_series_notifier.dart';
import 'package:movieflutter/presentation/provider/series/watchlist_series_notifier.dart';
import 'package:movieflutter/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movieflutter/presentation/provider/watchlist_movie_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistSeriesNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeSeriesPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case HomeSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeSeriesPage());
            case PopularSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedSeriesPage());
            case SearchSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchSeriesPage());
            case WatchlistSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistSeriesPage());
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
