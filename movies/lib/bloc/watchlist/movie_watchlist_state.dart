import 'package:domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

sealed class MovieWatchListState extends Equatable {}

class WatchListMovieMessage extends MovieWatchListState {
  final String message;

  WatchListMovieMessage(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}


class WatchlistMovieEmpty extends MovieWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WatchlistMovieInitial extends MovieWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WatchlistMovieLoading extends MovieWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WatchlistMovieError extends MovieWatchListState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistMovieHasData extends MovieWatchListState {
  final List<Movie> movies;

  WatchlistMovieHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}

class WatchlistMovieIsAdded extends MovieWatchListState {
  final bool isAdded;

  WatchlistMovieIsAdded(this.isAdded);

  @override
  // TODO: implement props
  List<Object?> get props => [isAdded];
}
