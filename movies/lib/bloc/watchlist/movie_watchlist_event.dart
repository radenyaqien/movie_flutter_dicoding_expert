import 'package:domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieWatchListEvent extends Equatable {
  const MovieWatchListEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchListMovie extends MovieWatchListEvent {
  const OnGetWatchListMovie();

  @override
  List<Object> get props => [];
}

class OnCheckStatusWatchList extends MovieWatchListEvent {
  final int id;

  const OnCheckStatusWatchList({required this.id});

  @override
  List<Object> get props => [id];
}

class AddMovieWatchList extends MovieWatchListEvent {
  final MovieDetail movieDetail;

  const AddMovieWatchList(this.movieDetail);

  @override
  // TODO: implement props
  List<Object> get props => [movieDetail];
}

class RemoveMovieWatchList extends MovieWatchListEvent {
  final MovieDetail movieDetail;

  const RemoveMovieWatchList(this.movieDetail);

  @override
  // TODO: implement props
  List<Object> get props => [movieDetail];
}
