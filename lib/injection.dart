import 'package:common/common/ssl_pinning/http_ssl_pinning.dart';
import 'package:common/data/datasources/db/database_helper.dart';
import 'package:common/data/datasources/movie_local_data_source.dart';
import 'package:common/data/datasources/movie_remote_data_source.dart';
import 'package:common/data/datasources/series/series_local_data_source.dart';
import 'package:common/data/datasources/series/series_remote_data_source.dart';
import 'package:common/data/repositories/movie_repository_impl.dart';
import 'package:common/data/repositories/series_repository_impl.dart';
import 'package:domain/repositories/movie_repository.dart';
import 'package:domain/repositories/series_repository.dart';
import 'package:domain/usecases/get_movie_detail.dart';
import 'package:domain/usecases/get_movie_recommendations.dart';
import 'package:domain/usecases/get_now_playing_movies.dart';
import 'package:domain/usecases/get_popular_movies.dart';
import 'package:domain/usecases/get_top_rated_movies.dart';
import 'package:domain/usecases/get_watchlist_movies.dart';
import 'package:domain/usecases/get_watchlist_status.dart';
import 'package:domain/usecases/remove_watchlist.dart';
import 'package:domain/usecases/save_watchlist.dart';
import 'package:domain/usecases/search_movies.dart';
import 'package:domain/usecases/series/get_now_playing_series.dart';
import 'package:domain/usecases/series/get_popular_series.dart';
import 'package:domain/usecases/series/get_series_detail.dart';
import 'package:domain/usecases/series/get_series_recommendations.dart';
import 'package:domain/usecases/series/get_top_rated_series.dart';
import 'package:domain/usecases/series/get_watchlist_series.dart';
import 'package:domain/usecases/series/get_watchlist_series_status.dart';
import 'package:domain/usecases/series/remove_watchlist_series.dart';
import 'package:domain/usecases/series/save_watchlist_series.dart';
import 'package:domain/usecases/series/search_series.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/bloc/movie_detail_notifier.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_bloc.dart';
import 'package:movies/bloc/popular/popular_movie_bloc.dart';
import 'package:movies/bloc/search/movie_search_bloc.dart';
import 'package:movies/bloc/toprated/toprated_movie_bloc.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:series/bloc/detail/detail_tv_series_bloc.dart';
import 'package:series/bloc/now_playing/now_playing_bloc.dart';
import 'package:series/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/bloc/recommendation/recommendation_tv_series_bloc.dart';
import 'package:series/bloc/search/search_tv_series_bloc.dart';
import 'package:series/bloc/toprated/toprated_series_bloc.dart';
import 'package:series/bloc/watchlist/watchlist_tv_series_bloc.dart';

final locator = GetIt.instance;

void init() {
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
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviePopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedSeriesBloc(locator()),
  );
  locator.registerFactory(
    () => PopularSeriesBloc(locator()),
  );
  locator.registerFactory(
    () => DetailTvSeriesBloc(locator()),
  );
  locator.registerFactory(
    () => SearchTvSeriesBloc(locator()),
  );
  locator.registerFactory(
    () => RecommendationTvSeriesBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => MovieWatchListBloc(locator(), locator(), locator(), locator()),
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
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
