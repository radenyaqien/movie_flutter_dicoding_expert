import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/usecases/series/remove_watchlist_series.dart';
import '../../dummy_series.dart';
import '../../helpers/series_test_helper.mocks.dart';

void main() {
  late RemoveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = RemoveWatchlistSeries(mockSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockSeriesRepository.removeWatchlistSeries(testSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.removeWatchlistSeries(testSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
