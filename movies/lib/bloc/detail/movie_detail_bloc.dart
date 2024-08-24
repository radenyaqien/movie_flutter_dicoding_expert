import 'package:domain/usecases/get_movie_detail.dart';
import 'package:domain/usecases/series/get_series_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/detail/movie_detail_event.dart';
import 'package:movies/bloc/detail/movie_detail_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getDetailMovie;

  DetailMovieBloc(
    this._getDetailMovie,
  ) : super(DetailMovieEmpty()) {
    on<FetchDetailMovie>((event, emit) async {
      emit(DetailMovieLoading());

      final id = event.id;
      final result = await _getDetailMovie.execute(id);

      result.fold(
        (failure) => emit(DetailMovieError(failure.message)),
        (data) => emit(DetailMovieHasData(data)),
      );
    });
  }
}
