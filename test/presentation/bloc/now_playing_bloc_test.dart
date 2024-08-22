import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/now_playing/now_playing_bloc.dart';
import 'package:series/bloc/now_playing/nowplaying_event.dart';
import 'package:series/bloc/now_playing/nowplaying_state.dart';


import '../../dummy_series.dart';
import 'mock/nowplaying_series_notifier_test.mocks.dart';

void main() {
  late MockGetNowPlayingSeries mockNowPlaying;
  late NowPlayingBloc nowPlayingBloc;

  setUp(() {
    mockNowPlaying = MockGetNowPlayingSeries();
    nowPlayingBloc = NowPlayingBloc(mockNowPlaying);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingBloc.state, NowPlayingSeriesEmpty());
  });

  blocTest<NowPlayingBloc, NowPlayingSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockNowPlaying.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockNowPlaying.execute());
      return FetchNowPlayingTvSeries().props;
    },
  );
  blocTest<NowPlayingBloc, NowPlayingSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockNowPlaying.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      const NowPlayingSeriesError("Server Failure"),
    ],
    verify: (bloc) {
      NowPlayingSeriesLoading();
    },
  );

  blocTest<NowPlayingBloc, NowPlayingSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockNowPlaying.execute()).thenAnswer((_) async => const Right([]));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesEmpty(),
    ],
    verify: (bloc) {
      verify(mockNowPlaying.execute());
      return FetchNowPlayingTvSeries().props;
    },
  );
}
