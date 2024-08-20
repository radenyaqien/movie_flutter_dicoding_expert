import 'package:dartz/dartz.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/domain/entities/series/tv_detail.dart';
import 'package:movieflutter/domain/repositories/series_repository.dart';

class RemoveWatchlistSeries {
  final SeriesRepository repository;

  RemoveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail movie) {
    return repository.removeWatchlistSeries(movie);
  }
}
