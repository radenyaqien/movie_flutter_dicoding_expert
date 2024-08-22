import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:domain/entities/series/series_detail.dart';
import 'package:domain/repositories/series_repository.dart';

class SaveWatchlistSeries {
  final SeriesRepository repository;

  SaveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail movie) {
    return repository.saveWatchlistSeries(movie);
  }
}
