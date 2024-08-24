import 'package:domain/entities/movie.dart';
import 'package:domain/entities/movie_detail.dart';
import 'package:domain/entities/series/series_detail.dart';
import 'package:equatable/equatable.dart';

sealed class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object?> get props => [];
}

class DetailMovieEmpty extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieError extends DetailMovieState {
  final String message;

  const DetailMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailMovieHasData extends DetailMovieState {
  final MovieDetail movie;

  const DetailMovieHasData(this.movie);

  @override
  List<Object?> get props => [movie];
}
