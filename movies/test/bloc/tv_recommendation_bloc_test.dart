import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/bloc/recommendation/recommendation_movie_bloc.dart';
import 'package:movies/bloc/recommendation/recommendation_movie_event.dart';
import 'package:movies/bloc/recommendation/recommendation_movie_state.dart';

import '../dummy_objects.dart';
import 'mock/movie_detail_test.mocks.dart';

void main() {
  late MockGetMovieRecommendations mockGetRecommendationsTv;
  late RecommendationMovieBloc tvRecommendationBloc;

  const testId = 1;

  setUp(() {
    mockGetRecommendationsTv = MockGetMovieRecommendations();
    tvRecommendationBloc = RecommendationMovieBloc(mockGetRecommendationsTv);
  });

  test("the initial state should be empty", () {
    expect(tvRecommendationBloc.state, RecommendationMovieEmpty());
  });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationMovie(testId)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationsTv.execute(testId));
      return const FetchRecommendationMovie(testId).props;
    },
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
      'should emit Loading state and then Error state when data failed to fetch',
      build: () {
        when(mockGetRecommendationsTv.execute(testId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationMovie(testId)),
      expect: () => [
            RecommendationMovieLoading(),
            const RecommendationMovieError('Server Failure'),
          ],
      verify: (bloc) => RecommendationMovieLoading());

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationMovie(testId)),
    expect: () => [RecommendationMovieLoading(), RecommendationMovieEmpty()],
  );
}
