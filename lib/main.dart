import 'package:about/about_page.dart';
import 'package:common/common/ssl_pinning/http_ssl_pinning.dart';
import 'package:common/routes.dart';
import 'package:commonui/constants.dart';
import 'package:commonui/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflutter/injection.dart' as di;
import 'package:movies/bloc/movie_detail_notifier.dart';
import 'package:movies/bloc/movie_list_notifier.dart';
import 'package:movies/bloc/movie_search_notifier.dart';
import 'package:movies/bloc/popular_movies_notifier.dart';
import 'package:movies/bloc/top_rated_movies_notifier.dart';
import 'package:movies/pages/home_movie_page.dart';
import 'package:movies/pages/movie_detail_page.dart';
import 'package:movies/pages/popular_movies_page.dart';
import 'package:movies/pages/search_page.dart';
import 'package:movies/pages/top_rated_movies_page.dart';
import 'package:movies/pages/watchlist_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:series/bloc/detail/detail_tv_series_bloc.dart';
import 'package:series/bloc/now_playing/now_playing_bloc.dart';
import 'package:series/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/bloc/recommendation/recommendation_tv_series_bloc.dart';
import 'package:series/bloc/search/search_tv_series_bloc.dart';
import 'package:series/bloc/toprated/toprated_series_bloc.dart';
import 'package:series/bloc/watchlist/watchlist_tv_series_bloc.dart';
import 'package:series/pages/series/home_series_page.dart';
import 'package:series/pages/series/now_playing_series_page.dart';
import 'package:series/pages/series/popular_series_page.dart';
import 'package:series/pages/series/search_series_page.dart';
import 'package:series/pages/series/series_detail_page.dart';
import 'package:series/pages/series/top_rated_series_page.dart';
import 'package:series/pages/series/watchlist_series_page.dart';

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
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedSeriesBloc>(),
        ),
        BlocProvider<NowPlayingBloc>(
          create: (_) => di.locator<NowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvSeriesBloc>(),
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
            case homeMovieRoute:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case popularMovieRoute:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case topRatedMovieRoute:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchMovieRoute:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case watchListMovieRoute:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case homeSeriesRoute:
              return MaterialPageRoute(builder: (_) => const HomeSeriesPage());
            case popularSeriesRoute:
              return MaterialPageRoute(
                  builder: (_) => const PopularSeriesPage());
            case topRatedSeriesRoute:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedSeriesPage());
            case searchSeriesRoute:
              return CupertinoPageRoute(
                  builder: (_) => const SearchSeriesPage());
            case watchListSeriesRoute:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistSeriesPage());
            case nowPlayingSeriesRoute:
              return MaterialPageRoute(
                  builder: (_) => const NowPlayingSeriesPage());
            case detailSeriesRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case aboutRoute:
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
