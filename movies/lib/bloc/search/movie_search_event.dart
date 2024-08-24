import 'package:equatable/equatable.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class OnSearchMovie extends MovieSearchEvent {
  final String query;

  const OnSearchMovie(this.query);

  @override
  List<Object> get props => [query];
}
