import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/bloc/detail/movie_detail_bloc.dart';
import 'package:movies/bloc/detail/movie_detail_event.dart';
import 'package:movies/bloc/detail/movie_detail_state.dart';

import 'mock/movie_detail_test.mocks.dart';

void main() {
  late MockGetMovieDetail mockGetTvDetail;
  late DetailMovieBloc tvDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetTvDetail = MockGetMovieDetail();
    tvDetailBloc = DetailMovieBloc(mockGetTvDetail);
  });

  test('the initial state should be empty', () {
    expect(tvDetailBloc.state, DetailMovieEmpty());
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailMovie(testId)),
    expect: () => [
      DetailMovieLoading(),
      const DetailMovieError('Server Failure'),
    ],
    verify: (bloc) => DetailMovieLoading(),
  );
}
