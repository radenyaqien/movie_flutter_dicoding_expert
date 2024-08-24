import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_event.dart';
import 'package:movies/bloc/watchlist/movie_watchlist_state.dart';

import '../dummy_objects.dart';
import 'mock/movie_detail_test.mocks.dart';

void main() {
  late MockGetWatchlistMovie mockGetWatchlistTv;
  late MockGetWatchListMovieStatus mockGetWatchlistStatusTv;
  late MockSaveWatchlistMovie mockSaveWatchlistTv;
  late MockRemoveWatchlistMovie mockRemoveWatchlistTv;
  late MovieWatchListBloc tvWatchListBloc;

  setUp(() {
    mockRemoveWatchlistTv = MockRemoveWatchlistMovie();
    mockGetWatchlistStatusTv = MockGetWatchListMovieStatus();
    mockGetWatchlistTv = MockGetWatchlistMovie();
    mockSaveWatchlistTv = MockSaveWatchlistMovie();
    tvWatchListBloc = MovieWatchListBloc(mockGetWatchlistTv,
        mockRemoveWatchlistTv, mockSaveWatchlistTv, mockGetWatchlistStatusTv);
  });

  test('the initial state should be Initial state', () {
    expect(tvWatchListBloc.state, WatchlistMovieInitial());
  });

  group(
    'get watchlist tv shows test cases',
    () {
      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(const OnGetWatchListMovie()),
        expect: () =>
            [WatchlistMovieLoading(), WatchlistMovieHasData(testMovieList)],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
          return const OnGetWatchListMovie().props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
          'should emit Loading state and then Error state when watchlist data failed to retrieved',
          build: () {
            when(mockGetWatchlistTv.execute()).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
            return tvWatchListBloc;
          },
          act: (bloc) => bloc.add(OnGetWatchListMovie()),
          expect: () => [
            WatchlistMovieLoading(),
                WatchlistMovieError('Server Failure'),
              ],
          verify: (bloc) => WatchlistMovieLoading);

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => const Right([]));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(const OnGetWatchListMovie()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieEmpty(),
        ],
      );
    },
  );

  group(
    'get watchlist status test cases',
    () {
      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchlistStatusTv.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(OnCheckStatusWatchList(id: testMovieDetail.id)),
        expect: () => [
          WatchlistMovieIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatusTv.execute(testMovieDetail.id));
          return OnCheckStatusWatchList(id: testMovieDetail.id).props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchlistStatusTv.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(OnCheckStatusWatchList(id: testMovieDetail.id)),
        expect: () => [
          WatchlistMovieIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatusTv.execute(testMovieDetail.id));
          return OnCheckStatusWatchList(id: testMovieDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlistTv.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("Add Successfully"));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(AddMovieWatchList(testMovieDetail)),
        expect: () => [
          WatchListMovieMessage("Add Successfully"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTv.execute(testMovieDetail));
          return AddMovieWatchList(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlistTv.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(AddMovieWatchList(testMovieDetail)),
        expect: () => [
          WatchlistMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTv.execute(testMovieDetail));
          return AddMovieWatchList(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlistTv.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("Remove Successfully"));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieWatchList(testMovieDetail)),
        expect: () => [
          WatchListMovieMessage("Remove Successfully"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTv.execute(testMovieDetail));
          return RemoveMovieWatchList(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlistTv.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieWatchList(testMovieDetail)),
        expect: () => [
          WatchlistMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTv.execute(testMovieDetail));
          return const RemoveMovieWatchList(testMovieDetail).props;
        },
      );
    },
  );
}
