import 'package:domain/entities/series/series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecases/series/search_series.dart';



part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvSeriesLoading());

      final result = await _searchTvSeries.execute(query);
      result.fold(
        (failure) {
          emit(SearchTvSeriesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(SearchTvSeriesEmpty());
          } else {
            emit(SearchTvSeriesHasData(data));
          }
        },
      );
    });
  }
}
