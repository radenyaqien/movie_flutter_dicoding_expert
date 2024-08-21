import 'package:dartz/dartz.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/domain/entities/series/series.dart';
import 'package:movieflutter/domain/repositories/series_repository.dart';

class SearchSeries {
  final SeriesRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
