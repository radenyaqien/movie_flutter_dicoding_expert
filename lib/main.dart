import 'package:firebase_core/firebase_core.dart';
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
import 'package:movieflutter/presentation/pages/series/now_playing_series_page.dart';
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
import 'package:movieflutter/presentation/provider/series/nowplaying_series_notifier.dart';
import 'package:movieflutter/presentation/provider/series/popular_series_notifier.dart';
import 'package:movieflutter/presentation/provider/series/series_detail_notifier.dart';
import 'package:movieflutter/presentation/provider/series/series_list_notifier.dart';
import 'package:movieflutter/presentation/provider/series/series_search_notifier.dart';
import 'package:movieflutter/presentation/provider/series/top_rated_series_notifier.dart';
import 'package:movieflutter/presentation/provider/series/watchlist_series_notifier.dart';
import 'package:movieflutter/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movieflutter/presentation/provider/watchlist_movie_notifier.dart';
import 'package:provider/provider.dart';

import 'common/ssl_pinning/http_ssl_pinning.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HttpSSLPinning.init();
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          create: (_) => di.locator<NowPlayingSeriesNotifier>(),
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
        home: const HomeSeriesPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());
            case HomeSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeSeriesPage());
            case PopularSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const PopularSeriesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const TopRatedSeriesPage());
            case SearchSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchSeriesPage());
            case WatchlistSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistSeriesPage());
            case NowPlayingSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const NowPlayingSeriesPage());
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
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
