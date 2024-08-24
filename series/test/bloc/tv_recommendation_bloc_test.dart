import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/util/failure.dart';
import 'package:series/bloc/recommendation/recommendation_tv_series_bloc.dart';

import '../dummy_series.dart';
import 'mock/series_detail_notifier_test.mocks.dart';

void main() {
  late MockGetSeriesRecommendations mockGetRecommendationsTv;
  late RecommendationTvSeriesBloc tvRecommendationBloc;

  const testId = 1;

  setUp(() {
    mockGetRecommendationsTv = MockGetSeriesRecommendations();
    tvRecommendationBloc = RecommendationTvSeriesBloc(mockGetRecommendationsTv);
  });

  test("the initial state should be empty", () {
    expect(tvRecommendationBloc.state, RecommendationTvSeriesEmpty());
  });

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => Right(testSeriesList));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(testId)),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationsTv.execute(testId));
      return const FetchRecommendationTvSeries(testId).props;
    },
  );

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
      'should emit Loading state and then Error state when data failed to fetch',
      build: () {
        when(mockGetRecommendationsTv.execute(testId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationTvSeries(testId)),
      expect: () => [
            RecommendationTvSeriesLoading(),
            const RecommendationTvSeriesError('Server Failure'),
          ],
      verify: (bloc) => RecommendationTvSeriesLoading());

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(testId)),
    expect: () =>
        [RecommendationTvSeriesLoading(), RecommendationTvSeriesEmpty()],
  );
}
