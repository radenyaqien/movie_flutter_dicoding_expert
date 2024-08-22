import 'package:dartz/dartz.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/repositories/series_repository.dart';
import 'package:domain/util/failure.dart';



class GetNowPlayingSeries {
  final SeriesRepository repository;

  GetNowPlayingSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getNowPlayingSeries();
  }
}
