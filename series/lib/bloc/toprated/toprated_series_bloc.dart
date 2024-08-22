import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecases/series/get_top_rated_series.dart';
import 'package:series/bloc/toprated/toprated_series_event.dart';
import 'package:series/bloc/toprated/toprated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries _getTopRatedSeries;

  TopRatedSeriesBloc(this._getTopRatedSeries) : super(TopRatedSeriesEmpty()) {
    on<FetchTopRatedSeries>((event, emit) async {
      emit(TopRatedSeriesLoading());

      final result = await _getTopRatedSeries.execute();

      result.fold(
        (failure) => emit(TopRatedSeriesError(failure.message)),
        (data) {
          if(data.isEmpty){
            emit(TopRatedSeriesEmpty());
          }else{
            emit(TopRatedSeriesHasData(data));
          }
        }
      );
    });
  }
}
