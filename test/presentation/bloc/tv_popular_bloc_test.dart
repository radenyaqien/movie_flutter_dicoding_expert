import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/bloc/popular_series/popular_series_event.dart';
import 'package:series/bloc/popular_series/popular_series_state.dart';

import '../../dummy_series.dart';
import 'mock/popular_series_notifier_test.mocks.dart';

void main() {
  late MockGetPopularSeries mockGetTvPopular;
  late PopularSeriesBloc tvPopularBloc;

  setUp(() {
    mockGetTvPopular = MockGetPopularSeries();
    tvPopularBloc = PopularSeriesBloc(mockGetTvPopular);
  });

  test('the initial state should be empty', () {
    expect(tvPopularBloc.state, PopularSeriesEmpty());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularSeries()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvPopular.execute());
      return FetchPopularSeries().props;
    },
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularSeries()),
    expect: () => [
      PopularSeriesLoading(),
      const PopularSeriesError('Server Failure'),
    ],
    verify: (bloc) => PopularSeriesLoading(),
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvPopular.execute()).thenAnswer((_) async => const Right([]));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularSeries()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesEmpty(),
    ],
  );
}
