import 'package:dartz/dartz.dart';
import 'package:domain/entities/series/series_detail.dart';

import 'package:domain/util/failure.dart';
import 'package:domain/repositories/series_repository.dart';

class GetSeriesDetail {
  final SeriesRepository repository;

  GetSeriesDetail(this.repository);

  Future<Either<Failure, SeriesDetail>> execute(int id) {
    return repository.getSeriesDetail(id);
  }
}
