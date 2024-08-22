part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object?> get props => [];
}

class SearchTvSeriesInitial extends SearchTvSeriesState {}

class SearchTvSeriesEmpty extends SearchTvSeriesState {}

class SearchTvSeriesLoading extends SearchTvSeriesState {}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;

  const SearchTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchTvSeriesHasData extends SearchTvSeriesState {
  final List<Series> series;

  const SearchTvSeriesHasData(this.series);

  @override
  List<Object?> get props => [series];
}
