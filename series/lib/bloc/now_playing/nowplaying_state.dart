import 'package:equatable/equatable.dart';
import 'package:domain/entities/series/series.dart';

abstract class NowPlayingSeriesState extends Equatable {
  const NowPlayingSeriesState();

  @override
  List<Object?> get props => [];
}

class NowPlayingSeriesEmpty extends NowPlayingSeriesState {}

class NowPlayingSeriesLoading extends NowPlayingSeriesState {}

class NowPlayingSeriesError extends NowPlayingSeriesState {
  final String message;

  const NowPlayingSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class NowPlayingSeriesHasData extends NowPlayingSeriesState {
  final List<Series> series;

  const NowPlayingSeriesHasData(this.series);

  @override
  List<Object?> get props => [series];
}
