import 'package:movieflutter/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/domain/usecases/series/get_watchlist_series_status.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../helpers/test_series_mocks.dart';

void main() {
  late GetWatchListSeriesStatus usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchListSeriesStatus(mockSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockSeriesRepository.isAddedToWatchlistTv(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
