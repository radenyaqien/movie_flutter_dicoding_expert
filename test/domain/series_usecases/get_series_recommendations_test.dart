import 'package:dartz/dartz.dart';
import 'package:movieflutter/domain/entities/movie.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/domain/usecases/series/get_series_recommendations.dart';
import 'package:movieflutter/domain/usecases/series/get_series_recommendations.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../helpers/test_series_mocks.dart';

void main() {
  late GetSeriesRecommendations usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesRecommendations(mockSeriesRepository);
  });

  final tId = 1;
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
