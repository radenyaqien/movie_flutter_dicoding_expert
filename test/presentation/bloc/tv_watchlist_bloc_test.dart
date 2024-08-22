import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/util/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/watchlist/watchlist_tv_series_bloc.dart';

import '../../dummy_series.dart';
import 'mock/series_detail_notifier_test.mocks.dart';
import 'mock/watchlist_series_notifier_test.mocks.dart';

void main() {
  late MockGetWatchlistSeries mockGetWatchlistTv;
  late MockGetWatchListSeriesStatus mockGetWatchlistStatusTv;
  late MockSaveWatchlistSeries mockSaveWatchlistTv;
  late MockRemoveWatchlistSeries mockRemoveWatchlistTv;
  late WatchlistTvSeriesBloc tvWatchListBloc;

  setUp(() {
    mockRemoveWatchlistTv = MockRemoveWatchlistSeries();
    mockGetWatchlistStatusTv = MockGetWatchListSeriesStatus();
    mockGetWatchlistTv = MockGetWatchlistSeries();
    mockSaveWatchlistTv = MockSaveWatchlistSeries();
    tvWatchListBloc = WatchlistTvSeriesBloc(mockGetWatchlistTv,
        mockRemoveWatchlistTv, mockSaveWatchlistTv, mockGetWatchlistStatusTv);
  });

  test('the initial state should be Initial state', () {
    expect(tvWatchListBloc.state, WatchlistTvSeriesInitial());
  });

  group(
    'get watchlist tv shows test cases',
    () {
      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => Right(testSeriesList));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesHasData(testSeriesList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
          return FetchWatchlistTvSeries().props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(mockGetWatchlistTv.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          const WatchlistTvSeriesError('Server Failure'),
        ],
        verify: (bloc) => WatchlistTvSeriesLoading(),
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => const Right([]));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
        expect: () => [
          WatchlistTvSeriesLoading(),
          WatchlistTvSeriesEmpty(),
        ],
      );
    },
  );

  group(
    'get watchlist status test cases',
    () {
      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchlistStatusTv.execute(testSeriesDetail.id))
              .thenAnswer((_) async => true);
          return tvWatchListBloc;
        },
        act: (bloc) =>
            bloc.add(LoadWatchlistStatusTvSeries(id: testSeriesDetail.id)),
        expect: () => [
          const WatchlistTvSeriesIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatusTv.execute(testSeriesDetail.id));
          return LoadWatchlistStatusTvSeries(id: testSeriesDetail.id).props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchlistStatusTv.execute(testSeriesDetail.id))
              .thenAnswer((_) async => false);
          return tvWatchListBloc;
        },
        act: (bloc) =>
            bloc.add(LoadWatchlistStatusTvSeries(id: testSeriesDetail.id)),
        expect: () => [
          const WatchlistTvSeriesIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatusTv.execute(testSeriesDetail.id));
          return LoadWatchlistStatusTvSeries(id: testSeriesDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlistTv.execute(testSeriesDetail))
              .thenAnswer((_) async => const Right("Add Successfully"));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(AddSeriesWatchList(testSeriesDetail)),
        expect: () => [
          const TvWatchListMessage("Add Successfully"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTv.execute(testSeriesDetail));
          return AddSeriesWatchList(testSeriesDetail).props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlistTv.execute(testSeriesDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(AddSeriesWatchList(testSeriesDetail)),
        expect: () => [
          const WatchlistTvSeriesError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTv.execute(testSeriesDetail));
          return AddSeriesWatchList(testSeriesDetail).props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlistTv.execute(testSeriesDetail))
              .thenAnswer((_) async => const Right("Remove Successfully"));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(RemoveseriesWatchList(testSeriesDetail)),
        expect: () => [
          const TvWatchListMessage("Remove Successfully"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTv.execute(testSeriesDetail));
          return RemoveseriesWatchList(testSeriesDetail).props;
        },
      );

      blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlistTv.execute(testSeriesDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return tvWatchListBloc;
        },
        act: (bloc) => bloc.add(RemoveseriesWatchList(testSeriesDetail)),
        expect: () => [
          const WatchlistTvSeriesError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTv.execute(testSeriesDetail));
          return RemoveseriesWatchList(testSeriesDetail).props;
        },
      );
    },
  );
}
