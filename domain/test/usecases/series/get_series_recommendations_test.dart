import 'package:dartz/dartz.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/usecases/series/get_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/series_test_helper.mocks.dart';

void main() {
  late GetSeriesRecommendations usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesRecommendations(mockSeriesRepository);
  });

  const tId = 1;
  final tSeries = <Series>[];

  test('should get list of series recommendations from the repository',
      () async {
    // arrange
    when(mockSeriesRepository.getSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSeries));
  });
}
