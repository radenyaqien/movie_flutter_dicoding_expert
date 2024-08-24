import 'package:domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

sealed class MoviePopularState extends Equatable {}

class PopularMovieEmpty extends MoviePopularState {
  @override
  List<Object?> get props => [];
}

class PopularMovieLoading extends MoviePopularState {
  @override
  List<Object?> get props => [];
}

class PopularMovieError extends MoviePopularState {
  final String message;

  PopularMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularMovieHasData extends MoviePopularState {
  final List<Movie> movies;

  PopularMovieHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
