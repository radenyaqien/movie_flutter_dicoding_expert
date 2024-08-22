import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/usecases/series/search_series.dart';

import '../../helpers/series_test_helper.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SearchSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];
  const tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockSeriesRepository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSeries));
  });
}
