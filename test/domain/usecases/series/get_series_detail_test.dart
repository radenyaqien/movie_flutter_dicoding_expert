import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/domain/usecases/series/get_series_detail.dart';

import '../../../dummy_data/series/series_dummy_objects.dart';
import '../../../helpers/test_series_mocks.dart';

void main() {
  late GetSeriesDetail usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesDetail(mockSeriesRepository);
  });

  const tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockSeriesRepository.getSeriesDetail(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testSeriesDetail));
  });
}
