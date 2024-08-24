import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_bloc.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_event.dart';
import 'package:movies/bloc/nowplaying/movie_nowplaying_state.dart';

import '../dummy_objects.dart';
import 'mock/movie_list_test.mocks.dart';

void main() {
  late MockGetNowPlayingMovie mockNowPlaying;
  late MovieNowPlayingBloc nowPlayingBloc;

  setUp(() {
    mockNowPlaying = MockGetNowPlayingMovie();
    nowPlayingBloc = MovieNowPlayingBloc(mockNowPlaying);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingBloc.state, NowPlayingMovieEmpty());
  });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockNowPlaying.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnFetchDataNowPlaying()),
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockNowPlaying.execute());
      return OnFetchDataNowPlaying().props;
    },
  );
  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockNowPlaying.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnFetchDataNowPlaying()),
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieError("Server Failure"),
    ],
    verify: (bloc) {
      NowPlayingMovieLoading();
    },
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockNowPlaying.execute()).thenAnswer((_) async => const Right([]));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnFetchDataNowPlaying()),
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieEmpty(),
    ],
    verify: (bloc) {
      verify(mockNowPlaying.execute());
      return OnFetchDataNowPlaying().props;
    },
  );
}
