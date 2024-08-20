import 'package:dartz/dartz.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/domain/repositories/series_repository.dart';

class GetSeriesRecommendations {
  final SeriesRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Series>>> execute(id) {
    return repository.getSeriesRecommendations(id);
  }
}
