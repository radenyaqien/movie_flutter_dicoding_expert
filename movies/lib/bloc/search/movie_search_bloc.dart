import 'package:domain/usecases/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/search/movie_search_event.dart';
import 'package:movies/bloc/search/movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(SearchMovieInitial()) {
    on<OnSearchMovie>((event, emit) async {
      emit(SearchMovieLoading());

      final result = await _searchMovies.execute(event.query);

      result.fold((failure) => emit(SearchMovieError(failure.message)), (data) {
        if (data.isEmpty) {
          emit(SearchMovieEmpty());
        } else {
          emit(SearchMovieHasData(data));
        }
      });
    });
  }
}
