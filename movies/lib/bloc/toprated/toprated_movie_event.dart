import 'package:equatable/equatable.dart';


abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnFetchData extends MovieTopRatedEvent {}
