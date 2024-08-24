import 'dart:async';

import 'package:domain/usecases/get_watchlist_movies.dart';
import 'package:domain/usecases/get_watchlist_status.dart';
import 'package:domain/usecases/remove_watchlist.dart';
import 'package:domain/usecases/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_watchlist_event.dart';
import 'movie_watchlist_state.dart';

class MovieWatchListBloc
    extends Bloc<MovieWatchListEvent, MovieWatchListState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;
  final GetWatchListStatus _getWatchListStatus;

  MovieWatchListBloc(this._getWatchlistMovies, this._removeWatchlist,
      this._saveWatchlist, this._getWatchListStatus)
      : super(WatchlistMovieInitial()) {
    on<OnGetWatchListMovie>(_onFetchWatchList);
    on<OnCheckStatusWatchList>(_onTvWatchListStatus);
    on<AddMovieWatchList>(_onTvWatchListAdd);
    on<RemoveMovieWatchList>(_onTvWatchListRemove);
  }

  FutureOr<void> _onFetchWatchList(
      OnGetWatchListMovie event, Emitter<MovieWatchListState> emit) async {
    emit(WatchlistMovieLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold((failure) => emit(WatchlistMovieError(failure.message)),
        (data) {
      if (data.isEmpty) {
        emit(WatchlistMovieEmpty());
      } else {
        emit(WatchlistMovieHasData(data));
      }
    });
  }

  FutureOr<void> _onTvWatchListStatus(
      OnCheckStatusWatchList event, Emitter<MovieWatchListState> emit) async {
    final id = event.id;
    final result = await _getWatchListStatus.execute(id);
    emit(WatchlistMovieIsAdded(result));
  }

  FutureOr<void> _onTvWatchListAdd(
      AddMovieWatchList event, Emitter<MovieWatchListState> emit) async {
    final tv = event.movieDetail;
    final result = await _saveWatchlist.execute(tv);
    result.fold((failure) {
      emit(WatchlistMovieError(failure.message));
    }, (success) {
      emit(WatchListMovieMessage(success));
    });
  }

  FutureOr<void> _onTvWatchListRemove(
      RemoveMovieWatchList event, Emitter<MovieWatchListState> emit) async {
    final tv = event.movieDetail;
    final result = await _removeWatchlist.execute(tv);

    result.fold((failure) {
      emit(WatchlistMovieError(failure.message));
    }, (success) {
      emit(WatchListMovieMessage(success));
    });
  }
}
