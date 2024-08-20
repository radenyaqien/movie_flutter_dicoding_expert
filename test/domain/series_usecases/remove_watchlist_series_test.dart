import 'package:dartz/dartz.dart';
import 'package:movieflutter/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/domain/usecases/series/remove_watchlist_series.dart';
import 'package:movieflutter/domain/usecases/series/remove_watchlist_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../dummy_data/series/series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../helpers/test_series_mocks.dart';

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
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.removeWatchlistSeries(testSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
