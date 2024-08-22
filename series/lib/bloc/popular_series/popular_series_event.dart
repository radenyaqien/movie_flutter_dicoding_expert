import 'package:equatable/equatable.dart';


abstract class PopularSeriesEvent extends Equatable {
  const PopularSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularSeries extends PopularSeriesEvent {}
