import 'package:dartz/dartz.dart';
import 'package:domain/usecases/series/save_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_series.dart';
import '../../helpers/series_test_helper.mocks.dart';

void main() {
  late SaveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SaveWatchlistSeries(mockSeriesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockSeriesRepository.saveWatchlistSeries(testSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.saveWatchlistSeries(testSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
