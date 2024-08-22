import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/repositories/series_repository.dart';

class GetTopRatedSeries {
  final SeriesRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getTopRatedSeries();
  }
}
