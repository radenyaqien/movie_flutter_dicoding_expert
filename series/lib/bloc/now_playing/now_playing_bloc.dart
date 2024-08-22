import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecases/series/get_now_playing_series.dart';
import 'package:series/bloc/now_playing/nowplaying_event.dart';
import 'package:series/bloc/now_playing/nowplaying_state.dart';

class NowPlayingBloc extends Bloc<NowplayingEvent, NowPlayingSeriesState> {
  final GetNowPlayingSeries _getNowPlayingSeries;

  NowPlayingBloc(this._getNowPlayingSeries) : super(NowPlayingSeriesEmpty()) {
    on<FetchNowPlayingTvSeries>((event, emit) async {
      emit(NowPlayingSeriesLoading());

      final result = await _getNowPlayingSeries.execute();

      result.fold(
        (failure) => emit(NowPlayingSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(NowPlayingSeriesEmpty());
          } else {
            emit(NowPlayingSeriesHasData(data));
          }

        },
      );
    });
  }
}
