import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/domain/entities/series/series.dart';
import 'package:movieflutter/domain/usecases/series/get_series_detail.dart';
import 'package:movieflutter/domain/usecases/series/get_series_recommendations.dart';
import 'package:movieflutter/domain/usecases/series/get_watchlist_series_status.dart';
import 'package:movieflutter/domain/usecases/series/remove_watchlist_series.dart';
import 'package:movieflutter/domain/usecases/series/save_watchlist_series.dart';
import 'package:movieflutter/presentation/provider/series/series_detail_notifier.dart';

import '../../../dummy_data/series/series_dummy_objects.dart';
import 'series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendations,
  GetWatchListSeriesStatus,
  SaveWatchlistSeries,
  RemoveWatchlistSeries,
])
void main() {
  late SeriesDetailNotifier provider;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListSeriesStatus mockGetWatchlistStatus;
  late MockSaveWatchlistSeries mockSaveWatchlist;
  late MockRemoveWatchlistSeries mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListSeriesStatus();
    mockSaveWatchlist = MockSaveWatchlistSeries();
    mockRemoveWatchlist = MockRemoveWatchlistSeries();
    provider = SeriesDetailNotifier(
      getSeriesDetail: mockGetSeriesDetail,
      getSeriesRecommendations: mockGetSeriesRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;

  final tSeries = Series(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    firstAirDate: DateTime.parse("2004-09-01"),
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originCountry: const ["US"],
    originalLanguage: "en",
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  final tSeriesList = <Series>[tSeries];

  void arrangeUsecase() {
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSeriesList));
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesDetail.execute(tId));
      verify(mockGetSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.series, testSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.seriesRecommendations, tSeriesList);
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesRecommendations.execute(tId));
      expect(provider.seriesRecommendations, tSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.seriesRecommendations, tSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testSeriesDetail));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockSaveWatchlist.execute(testSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
