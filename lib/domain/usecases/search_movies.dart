import 'package:dartz/dartz.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/domain/entities/movie.dart';
import 'package:movieflutter/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
