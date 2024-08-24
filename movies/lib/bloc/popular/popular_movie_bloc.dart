import 'package:domain/usecases/get_popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/popular/movie_toprated_state.dart';
import 'package:movies/bloc/popular/popular_movie_event.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(PopularMovieEmpty()) {
    on<OnFetchDataPopular>((event, emit) async {
      emit(PopularMovieLoading());

      final result = await _getPopularMovies.execute();

      result.fold((failure) => emit(PopularMovieError(failure.message)),
          (data) {
        if (data.isEmpty) {
          emit(PopularMovieEmpty());
        } else {
          emit(PopularMovieHasData(data));
        }
      });
    });
  }
}
