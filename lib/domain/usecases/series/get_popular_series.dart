import 'package:dartz/dartz.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/domain/entities/series/series.dart';
import 'package:movieflutter/domain/repositories/series_repository.dart';

class GetPopularSeries {
  final SeriesRepository repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getPopularSeries();
  }
}
