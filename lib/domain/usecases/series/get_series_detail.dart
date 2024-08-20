import 'package:dartz/dartz.dart';
import 'package:movieflutter/domain/entities/series/tv_detail.dart';

import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/domain/repositories/series_repository.dart';

class GetSeriesDetail {
  final SeriesRepository repository;

  GetSeriesDetail(this.repository);

  Future<Either<Failure, SeriesDetail>> execute(int id) {
    return repository.getSeriesDetail(id);
  }
}
