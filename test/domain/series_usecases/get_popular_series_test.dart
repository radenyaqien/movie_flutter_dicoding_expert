import 'package:dartz/dartz.dart';
import 'package:movieflutter/domain/entities/movie.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/domain/usecases/get_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/domain/usecases/series/get_popular_series.dart';
import 'package:movieflutter/domain/usecases/series/get_popular_series.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../helpers/test_series_mocks.dart';

void main() {
  late GetPopularSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetPopularSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  group('GetPopularSeries Tests', () {
    group('execute', () {
      test(
          'should get list of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockSeriesRepository.getPopularSeries())
            .thenAnswer((_) async => Right(tSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tSeries));
      });
    });
  });
}
