import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecases/series/get_popular_series.dart';
import 'package:series/bloc/popular_series/popular_series_event.dart';
import 'package:series/bloc/popular_series/popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries _getPopularSeries;

  PopularSeriesBloc(this._getPopularSeries) : super(PopularSeriesEmpty()) {
    on<FetchPopularSeries>((event, emit) async {
      emit(PopularSeriesLoading());

      final result = await _getPopularSeries.execute();

      result.fold(
        (failure) => emit(PopularSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(PopularSeriesEmpty());
          } else {
            emit(PopularSeriesHasData(data));
          }
        },
      );
    });
  }
}
