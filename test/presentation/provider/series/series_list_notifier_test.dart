import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/domain/entities/series/series.dart';
import 'package:movieflutter/domain/usecases/get_now_playing_movies.dart';
import 'package:movieflutter/domain/usecases/get_popular_movies.dart';
import 'package:movieflutter/domain/usecases/get_top_rated_movies.dart';
import 'package:movieflutter/presentation/provider/series/series_list_notifier.dart';

import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late SeriesListNotifier provider;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    provider = SeriesListNotifier(
      getNowPlayingSeries: mockGetNowPlayingSeries,
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

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

  group('now playing series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchNowPlayingSeries();
      // assert
      verify(mockGetNowPlayingSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Loaded);
      expect(provider.popularSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Loaded);
      expect(provider.topRatedSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
