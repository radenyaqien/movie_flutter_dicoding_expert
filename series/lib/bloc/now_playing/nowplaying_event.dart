import 'package:equatable/equatable.dart';


abstract class NowplayingEvent extends Equatable {
  const NowplayingEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingTvSeries extends NowplayingEvent {}
