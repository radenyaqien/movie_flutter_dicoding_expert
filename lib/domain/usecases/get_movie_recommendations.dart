import 'package:dartz/dartz.dart';
import 'package:movieflutter/domain/entities/movie.dart';
import 'package:movieflutter/domain/repositories/movie_repository.dart';
import 'package:movieflutter/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
