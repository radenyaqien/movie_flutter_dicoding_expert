import 'package:domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/toprated/movie_toprated_state.dart';
import 'package:movies/bloc/toprated/toprated_movie_event.dart';

class TopRatedMovieBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<OnFetchData>((event, emit) async {
      emit(TopRatedMovieLoading());

      final result = await _getTopRatedMovies.execute();

      result.fold((failure) => emit(TopRatedMovieError(failure.message)),
          (data) {
        if (data.isEmpty) {
          emit(TopRatedMovieEmpty());
        } else {
          emit(TopRatedMovieHasData(data));
        }
      });
    });
  }
}
