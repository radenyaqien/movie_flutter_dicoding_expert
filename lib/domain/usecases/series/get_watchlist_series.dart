import 'package:dartz/dartz.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/domain/repositories/series_repository.dart';

class GetWatchlistSeries {
  final SeriesRepository _repository;

  GetWatchlistSeries(this._repository);

  Future<Either<Failure, List<Series>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
