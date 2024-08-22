import 'package:dartz/dartz.dart';
import 'package:domain/entities/series/series.dart';
import 'package:domain/usecases/series/get_now_playing_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/series_test_helper.mocks.dart';

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
