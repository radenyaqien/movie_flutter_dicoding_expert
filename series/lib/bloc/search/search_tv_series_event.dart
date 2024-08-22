part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class OnQueryChanged extends SearchTvSeriesEvent {
  final String query;

  const OnQueryChanged(this.query);
  // coverage:ignore-start
  @override
  List<Object?> get props => [query];
  // coverage:ignore-end
}
