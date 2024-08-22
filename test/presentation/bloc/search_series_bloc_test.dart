import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/util/failure.dart';
import 'package:series/bloc/search/search_tv_series_bloc.dart';
import '../../dummy_series.dart';
import 'mock/search_series_notifier_test.mocks.dart';

void main() {
  late MockSearchSeries mockGetTvOnTheAir;
  late SearchTvSeriesBloc tvOnTheAirBloc;

  setUp(() {
    mockGetTvOnTheAir = MockSearchSeries();
    tvOnTheAirBloc = SearchTvSeriesBloc(mockGetTvOnTheAir);
  });

  test('the initial state should be initial', () {
    expect(tvOnTheAirBloc.state, SearchTvSeriesInitial());
  });

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvOnTheAir.execute("r"))
          .thenAnswer((_) async => Right(testSeriesList));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged("r")),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute("r"));
      return const OnQueryChanged("r").props;
    },
  );

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvOnTheAir.execute("r"))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged("r")),
    expect: () => [
      SearchTvSeriesLoading(),
      const SearchTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => SearchTvSeriesLoading(),
  );

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvOnTheAir.execute("r"))
          .thenAnswer((_) async => const Right([]));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged("r")),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesEmpty(),
    ],
  );
}
