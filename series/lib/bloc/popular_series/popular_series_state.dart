import 'package:equatable/equatable.dart';
import 'package:domain/entities/series/series.dart';

abstract class PopularSeriesState extends Equatable {
  const PopularSeriesState();

  @override
  List<Object?> get props => [];
}

class PopularSeriesEmpty extends PopularSeriesState {}

class PopularSeriesLoading extends PopularSeriesState {}

class PopularSeriesError extends PopularSeriesState {
  final String message;

  const PopularSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularSeriesHasData extends PopularSeriesState {
  final List<Series> series;

  const PopularSeriesHasData(this.series);

  @override
  List<Object?> get props => [series];
}
