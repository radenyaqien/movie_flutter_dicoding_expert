import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/toprated/toprated_series_bloc.dart';
import 'package:series/bloc/toprated/toprated_series_event.dart';
import 'package:series/bloc/toprated/toprated_series_state.dart';

import '../../dummy_series.dart';
import 'mock/toprated_series_notifier_test.mocks.dart';

void main() {
  late MockGetTopRatedSeries mockGetTvTopRated;
  late TopRatedSeriesBloc tvTopRatedBloc;

  setUp(() {
    mockGetTvTopRated = MockGetTopRatedSeries();
    tvTopRatedBloc = TopRatedSeriesBloc(mockGetTvTopRated);
  });

  test('the initial state should be empty', () {
    expect(tvTopRatedBloc.state, TopRatedSeriesEmpty());
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvTopRated.execute());
      return FetchTopRatedSeries().props;
    },
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    expect: () => [
      TopRatedSeriesLoading(),
      const TopRatedSeriesError('Server Failure'),
    ],
    verify: (bloc) => TopRatedSeriesLoading(),
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => const Right([]));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesEmpty(),
    ],
  );
}
