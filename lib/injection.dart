import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movieflutter/data/datasources/db/database_helper.dart';
import 'package:movieflutter/data/datasources/movie_local_data_source.dart';
import 'package:movieflutter/data/datasources/movie_remote_data_source.dart';
import 'package:movieflutter/data/datasources/series/series_local_data_source.dart';
import 'package:movieflutter/data/datasources/series/series_remote_data_source.dart';
import 'package:movieflutter/data/repositories/movie_repository_impl.dart';
import 'package:movieflutter/data/repositories/series_repository_impl.dart';
import 'package:movieflutter/domain/repositories/movie_repository.dart';
import 'package:movieflutter/domain/repositories/series_repository.dart';
import 'package:movieflutter/domain/usecases/get_movie_detail.dart';
import 'package:movieflutter/domain/usecases/get_movie_recommendations.dart';
import 'package:movieflutter/domain/usecases/get_now_playing_movies.dart';
import 'package:movieflutter/domain/usecases/get_popular_movies.dart';
import 'package:movieflutter/domain/usecases/get_top_rated_movies.dart';
import 'package:movieflutter/domain/usecases/get_watchlist_movies.dart';
import 'package:movieflutter/domain/usecases/get_watchlist_status.dart';
import 'package:movieflutter/domain/usecases/remove_watchlist.dart';
import 'package:movieflutter/domain/usecases/save_watchlist.dart';
import 'package:movieflutter/domain/usecases/search_movies.dart';
import 'package:movieflutter/domain/usecases/series/get_now_playing_series.dart';
import 'package:movieflutter/domain/usecases/series/get_popular_series.dart';
import 'package:movieflutter/domain/usecases/series/get_series_recommendations.dart';
import 'package:movieflutter/domain/usecases/series/get_top_rated_series.dart';
import 'package:movieflutter/domain/usecases/series/get_watchlist_series.dart';
import 'package:movieflutter/domain/usecases/series/get_watchlist_series_status.dart';
import 'package:movieflutter/domain/usecases/series/remove_watchlist_series.dart';
import 'package:movieflutter/domain/usecases/series/save_watchlist_series.dart';
import 'package:movieflutter/domain/usecases/series/search_series.dart';
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

import 'domain/usecases/series/get_series_detail.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesListNotifier(
      getPopularSeries: locator(),
      getNowPlayingSeries: locator(),
      getTopRatedSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesDetailNotifier(
      getSeriesDetail: locator(),
      getSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularSeriesNotifier(getPopularSeries: locator()),
  );
  locator.registerFactory(
    () => TopRatedSeriesNotifier(
      getTopRatedSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingSeriesNotifier(
      getNowPlayingSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesSearchNotifier(
      searchSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistSeriesNotifier(
      getWatchlistSeries: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListSeriesStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
