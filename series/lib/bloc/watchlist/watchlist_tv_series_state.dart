part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object?> get props => [];
}

class TvWatchListMessage extends WatchlistTvSeriesState {
  final String message;

  const TvWatchListMessage(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesInitial extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTvSeriesHasData extends WatchlistTvSeriesState {
  final List<Series> series;

  const WatchlistTvSeriesHasData(this.series);

  @override
  List<Object?> get props => [series];
}

class WatchlistTvSeriesIsAdded extends WatchlistTvSeriesState {
  final bool isAdded;

  const WatchlistTvSeriesIsAdded(this.isAdded);

  @override
  // TODO: implement props
  List<Object?> get props => [isAdded];
}
