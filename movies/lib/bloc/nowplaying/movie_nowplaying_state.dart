import 'package:domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

sealed class MovieNowPlayingState extends Equatable {}

class NowPlayingMovieEmpty extends MovieNowPlayingState {
  @override
  List<Object?> get props => [];
}

class NowPlayingMovieLoading extends MovieNowPlayingState {
  @override
  List<Object?> get props => [];
}

class NowPlayingMovieError extends MovieNowPlayingState {
  final String message;

  NowPlayingMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class NowPlayingMovieHasData extends MovieNowPlayingState {
  final List<Movie> movies;

  NowPlayingMovieHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
