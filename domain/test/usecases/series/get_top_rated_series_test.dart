import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/usecases/series/get_top_rated_series.dart';

import '../../helpers/series_test_helper.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetTopRatedSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  test('should get list of series from repository', () async {
    // arrange
    when(mockSeriesRepository.getTopRatedSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
