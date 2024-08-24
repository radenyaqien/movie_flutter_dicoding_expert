import 'package:domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/recommendation/recommendation_movie_event.dart';
import 'package:movies/bloc/recommendation/recommendation_movie_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations _getRecommendationMovie;

  RecommendationMovieBloc(this._getRecommendationMovie)
      : super(RecommendationMovieEmpty()) {
    on<FetchRecommendationMovie>((event, emit) async {
      emit(RecommendationMovieLoading());

      final id = event.id;
      final result = await _getRecommendationMovie.execute(id);

      result.fold(
        (failure) => emit(RecommendationMovieError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(RecommendationMovieEmpty());
          } else {
            emit(RecommendationMovieHasData(data));
          }
        },
      );
    });
  }
}
