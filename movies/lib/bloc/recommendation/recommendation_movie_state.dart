import 'package:domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

sealed class RecommendationMovieState extends Equatable {
  const RecommendationMovieState();

  @override
  List<Object?> get props => [];
}

class RecommendationMovieEmpty extends RecommendationMovieState {}

class RecommendationMovieLoading extends RecommendationMovieState {}

class RecommendationMovieError extends RecommendationMovieState {
  final String message;

  const RecommendationMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecommendationMovieHasData extends RecommendationMovieState {
  final List<Movie> movie;

  const RecommendationMovieHasData(this.movie);

  @override
  List<Object?> get props => [movie];
}
