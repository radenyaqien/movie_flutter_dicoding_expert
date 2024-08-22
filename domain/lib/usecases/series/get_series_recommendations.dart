import 'package:dartz/dartz.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/util/failure.dart';
import 'package:domain/repositories/series_repository.dart';

class GetSeriesRecommendations {
  final SeriesRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Series>>> execute(id) {
    return repository.getSeriesRecommendations(id);
  }
}
