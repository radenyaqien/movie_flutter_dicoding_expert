import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/util/failure.dart';
import 'package:series/bloc/detail/detail_tv_series_bloc.dart';

import 'mock/series_detail_notifier_test.mocks.dart';

void main() {
  late MockGetSeriesDetail mockGetTvDetail;
  late DetailTvSeriesBloc tvDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetTvDetail = MockGetSeriesDetail();
    tvDetailBloc = DetailTvSeriesBloc(mockGetTvDetail);
  });

  test('the initial state should be empty', () {
    expect(tvDetailBloc.state, DetailTvSeriesEmpty());
  });

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailTvSeries(testId)),
    expect: () => [
      DetailTvSeriesLoading(),
      const DetailTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => DetailTvSeriesLoading(),
  );
}
