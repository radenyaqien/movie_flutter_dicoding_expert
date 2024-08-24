import 'package:domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

sealed class MovieSearchState extends Equatable {}

class SearchMovieEmpty extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class SearchMovieLoading extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class SearchMovieError extends MovieSearchState {
  final String message;

  SearchMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchMovieInitial extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class SearchMovieHasData extends MovieSearchState {
  final List<Movie> movies;

  SearchMovieHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
