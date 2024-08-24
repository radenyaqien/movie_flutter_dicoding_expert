import 'package:domain/usecases/get_now_playing_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_event.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getPopularMovies;

  MovieNowPlayingBloc(this._getPopularMovies) : super(NowPlayingMovieEmpty()) {
    on<OnFetchDataNowPlaying>((event, emit) async {
      emit(NowPlayingMovieLoading());

      final result = await _getPopularMovies.execute();

      result.fold((failure) => emit(NowPlayingMovieError(failure.message)),
          (data) {
        if (data.isEmpty) {
          emit(NowPlayingMovieEmpty());
        } else {
          emit(NowPlayingMovieHasData(data));
        }
      });
    });
  }
}
