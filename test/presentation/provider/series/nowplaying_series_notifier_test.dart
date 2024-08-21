import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/common/failure.dart';
import 'package:movieflutter/common/state_enum.dart';
import 'package:movieflutter/domain/entities/series/series.dart';
import 'package:movieflutter/domain/usecases/series/get_now_playing_series.dart';
import 'package:movieflutter/presentation/provider/series/nowplaying_series_notifier.dart';

import 'nowplaying_series_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeries])
void main() {
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late NowPlayingSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    notifier =
        NowPlayingSeriesNotifier(getNowPlayingSeries: mockGetNowPlayingSeries)
          ..addListener(() {
            listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingSeries.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    notifier.fetchNowPlayingSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingSeries.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    await notifier.fetchNowPlayingSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.series, tSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingSeries.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
