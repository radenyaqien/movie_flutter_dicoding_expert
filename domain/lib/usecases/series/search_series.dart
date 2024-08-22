import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/repositories/series_repository.dart';

class SearchSeries {
  final SeriesRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
