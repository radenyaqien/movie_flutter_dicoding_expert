import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/bloc/popular/movie_toprated_state.dart';
import 'package:movies/bloc/popular/popular_movie_bloc.dart';
import 'package:movies/bloc/popular/popular_movie_event.dart';

import '../dummy_objects.dart';
import 'mock/movie_list_test.mocks.dart';

void main() {
  late MockGetPopularMovie mockGetTvPopular;
  late MoviePopularBloc tvPopularBloc;

  setUp(() {
    mockGetTvPopular = MockGetPopularMovie();
    tvPopularBloc = MoviePopularBloc(mockGetTvPopular);
  });

  test('the initial state should be empty', () {
    expect(tvPopularBloc.state, PopularMovieEmpty());
  });

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnFetchDataPopular()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTvPopular.execute());
      return OnFetchDataPopular().props;
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnFetchDataPopular()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Server Failure'),
    ],
    verify: (bloc) => PopularMovieLoading(),
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvPopular.execute()).thenAnswer((_) async => const Right([]));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnFetchDataPopular()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieEmpty(),
    ],
  );
}
