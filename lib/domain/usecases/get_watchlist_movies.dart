import 'package:dartz/dartz.dart';
import 'package:movieflutter/domain/entities/movie.dart';
import 'package:movieflutter/domain/repositories/movie_repository.dart';
import 'package:movieflutter/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
