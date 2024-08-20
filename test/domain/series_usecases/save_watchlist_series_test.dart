import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/domain/usecases/series/save_watchlist_series.dart';

import '../../dummy_data/series/series_dummy_objects.dart';
import '../../helpers/test_series_mocks.dart';

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
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.saveWatchlistSeries(testSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
