import 'package:equatable/equatable.dart';

abstract class RecommendationMovieEvent extends Equatable {
  const RecommendationMovieEvent();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
// coverage:ignore-end
}

class FetchRecommendationMovie extends RecommendationMovieEvent {
  final int id;

  const FetchRecommendationMovie(this.id);

  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
// coverage:ignore-end
}
