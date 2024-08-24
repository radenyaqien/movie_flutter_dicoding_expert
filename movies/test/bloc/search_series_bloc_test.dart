import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/bloc/search/movie_search_bloc.dart';
import 'package:movies/bloc/search/movie_search_event.dart';
import 'package:movies/bloc/search/movie_search_state.dart';

import '../dummy_objects.dart';
import 'mock/movie_list_test.mocks.dart';

void main() {
  late MockSearchMovie mockGetTvOnTheAir;
  late MovieSearchBloc tvOnTheAirBloc;

  setUp(() {
    mockGetTvOnTheAir = MockSearchMovie();
    tvOnTheAirBloc = MovieSearchBloc(mockGetTvOnTheAir);
  });

  test('the initial state should be initial', () {
    expect(tvOnTheAirBloc.state, SearchMovieInitial());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvOnTheAir.execute("r"))
          .thenAnswer((_) async => Right(testMovieList));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(const OnSearchMovie("r")),
    expect: () => [
      SearchMovieLoading(),
      SearchMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute("r"));
      return const OnSearchMovie("r").props;
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvOnTheAir.execute("r"))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(const OnSearchMovie("r")),
    expect: () => [
      SearchMovieLoading(),
      SearchMovieError('Server Failure'),
    ],
    verify: (bloc) => SearchMovieLoading(),
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvOnTheAir.execute("r"))
          .thenAnswer((_) async => const Right([]));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(const OnSearchMovie("r")),
    expect: () => [
      SearchMovieLoading(),
      SearchMovieEmpty(),
    ],
  );
}
