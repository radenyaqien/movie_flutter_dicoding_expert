import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/bloc/toprated/movie_toprated_state.dart';
import 'package:movies/bloc/toprated/toprated_movie_bloc.dart';
import 'package:movies/bloc/toprated/toprated_movie_event.dart';

import '../dummy_objects.dart';
import 'mock/movie_list_test.mocks.dart';

void main() {
  late MockGetTopRatedMovie mockGetTvTopRated;
  late TopRatedMovieBloc tvTopRatedBloc;

  setUp(() {
    mockGetTvTopRated = MockGetTopRatedMovie();
    tvTopRatedBloc = TopRatedMovieBloc(mockGetTvTopRated);
  });

  test('the initial state should be empty', () {
    expect(tvTopRatedBloc.state, TopRatedMovieEmpty());
  });

  blocTest<TopRatedMovieBloc, MovieTopRatedState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnFetchData()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTvTopRated.execute());
      return OnFetchData().props;
    },
  );

  blocTest<TopRatedMovieBloc, MovieTopRatedState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnFetchData()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError('Server Failure'),
    ],
    verify: (bloc) => TopRatedMovieLoading(),
  );

  blocTest<TopRatedMovieBloc, MovieTopRatedState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => const Right([]));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnFetchData()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieEmpty(),
    ],
  );
}
