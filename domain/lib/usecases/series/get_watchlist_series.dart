import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/repositories/series_repository.dart';

class GetWatchlistSeries {
  final SeriesRepository _repository;

  GetWatchlistSeries(this._repository);

  Future<Either<Failure, List<Series>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
