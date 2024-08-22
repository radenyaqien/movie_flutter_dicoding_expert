part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  // coverage:ignore-start
  @override
  List<Object?> get props => [];
// coverage:ignore-end
}

class FetchWatchlistTvSeries extends WatchlistTvSeriesEvent {}

class LoadWatchlistStatusTvSeries extends WatchlistTvSeriesEvent {
  final int id;

  const LoadWatchlistStatusTvSeries({required this.id});

  @override
  List<Object?> get props => [id];
}

class AddSeriesWatchList extends WatchlistTvSeriesEvent {
  final SeriesDetail seriesDetail;

  const AddSeriesWatchList(this.seriesDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [seriesDetail];
}

class RemoveseriesWatchList extends WatchlistTvSeriesEvent {
  final SeriesDetail seriesDetail;

  const RemoveseriesWatchList(this.seriesDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [seriesDetail];
}
