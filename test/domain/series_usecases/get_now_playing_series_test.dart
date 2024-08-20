import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/domain/usecases/series/get_now_playing_series.dart';

import '../../helpers/test_series_mocks.dart';

void main() {
  late GetNowPlayingSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetNowPlayingSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  test('should get list of series from the repository', () async {
    // arrange
    when(mockSeriesRepository.getNowPlayingSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
