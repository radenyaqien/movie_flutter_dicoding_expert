import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/entities/series/series_detail.dart';
import 'package:domain/usecases/series/get_watchlist_series.dart';
import 'package:domain/usecases/series/get_watchlist_series_status.dart';
import 'package:domain/usecases/series/remove_watchlist_series.dart';
import 'package:domain/usecases/series/save_watchlist_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistSeries _getWatchlistTvSeries;
  final RemoveWatchlistSeries _removeWatchlistSeries;
  final SaveWatchlistSeries _saveWatchlistSeries;
  final GetWatchListSeriesStatus _getWatchListSeriesStatus;

  WatchlistTvSeriesBloc(this._getWatchlistTvSeries, this._removeWatchlistSeries,
      this._saveWatchlistSeries, this._getWatchListSeriesStatus)
      : super(WatchlistTvSeriesInitial()) {
    on<FetchWatchlistTvSeries>(_onFetchTvWatchList);
    on<LoadWatchlistStatusTvSeries>(_onTvWatchListStatus);
    on<AddSeriesWatchList>(_onTvWatchListAdd);
    on<RemoveseriesWatchList>(_onTvWatchListRemove);
  }

  FutureOr<void> _onFetchTvWatchList(FetchWatchlistTvSeries event,
      Emitter<WatchlistTvSeriesState> emit) async {
    emit(WatchlistTvSeriesLoading());

    final result = await _getWatchlistTvSeries.execute();

    result.fold(
      (failure) => emit(WatchlistTvSeriesError(failure.message)),
      (data) {
        if (data.isEmpty) {
          emit(WatchlistTvSeriesEmpty());
        } else {
          emit(WatchlistTvSeriesHasData(data));
        }
      },
    );
  }

  FutureOr<void> _onTvWatchListStatus(LoadWatchlistStatusTvSeries event,
      Emitter<WatchlistTvSeriesState> emit) async {
    final id = event.id;
    final result = await _getWatchListSeriesStatus.execute(id);
    emit(WatchlistTvSeriesIsAdded(result));
  }

  FutureOr<void> _onTvWatchListAdd(
      AddSeriesWatchList event, Emitter<WatchlistTvSeriesState> emit) async {
    final tv = event.seriesDetail;
    final result = await _saveWatchlistSeries.execute(tv);
    result.fold((failure) {
      emit(WatchlistTvSeriesError(failure.message));
    }, (success) {
      emit(TvWatchListMessage(success));
    });
  }

  FutureOr<void> _onTvWatchListRemove(
      RemoveseriesWatchList event, Emitter<WatchlistTvSeriesState> emit) async {
    final tv = event.seriesDetail;
    final result = await _removeWatchlistSeries.execute(tv);

    result.fold((failure) {
      emit(WatchlistTvSeriesError(failure.message));
    }, (success) {
      emit(TvWatchListMessage(success));
    });
  }
}
