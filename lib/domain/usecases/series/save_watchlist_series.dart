import 'package:dartz/dartz.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/domain/entities/series/series_detail.dart';
import 'package:movieflutter/domain/repositories/series_repository.dart';

class SaveWatchlistSeries {
  final SeriesRepository repository;

  SaveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail movie) {
    return repository.saveWatchlistSeries(movie);
  }
}
