import 'package:domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

sealed class MovieTopRatedState extends Equatable {}

class TopRatedMovieEmpty extends MovieTopRatedState {
  @override
  List<Object?> get props => [];
}

class TopRatedMovieLoading extends MovieTopRatedState {
  @override
  List<Object?> get props => [];
}

class TopRatedMovieError extends MovieTopRatedState {
  final String message;

  TopRatedMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedMovieHasData extends MovieTopRatedState {
  final List<Movie> movies;

  TopRatedMovieHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
