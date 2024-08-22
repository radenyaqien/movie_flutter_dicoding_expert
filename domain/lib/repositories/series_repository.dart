import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';

import '../entities/series/series.dart';
import '../entities/series/series_detail.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getNowPlayingSeries();

  Future<Either<Failure, List<Series>>> getPopularSeries();

  Future<Either<Failure, List<Series>>> getTopRatedSeries();

  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id);

  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id);

  Future<Either<Failure, List<Series>>> searchSeries(String query);

  Future<Either<Failure, String>> saveWatchlistSeries(SeriesDetail movie);

  Future<Either<Failure, String>> removeWatchlistSeries(SeriesDetail movie);

  Future<bool> isAddedToWatchlistTv(int id);

  Future<Either<Failure, List<Series>>> getWatchlistSeries();
}
