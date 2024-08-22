import 'dart:async' as i7;

import 'package:dartz/dartz.dart' as i2;
import 'package:domain/entities/series/series.dart' as i9;
import 'package:domain/entities/series/series_detail.dart' as i10;
import 'package:domain/repositories/series_repository.dart' as i6;
import 'package:domain/util/failure.dart' as i8;
import 'package:mockito/mockito.dart' as i1;

class _FakeEither<L, R> extends i1.Fake implements i2.Either<L, R> {}

///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRepository extends i1.Mock implements i6.SeriesRepository {
  MockSeriesRepository() {
    i1.throwOnMissingStub(this);
  }

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> getNowPlayingSeries() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingSeries, []),
              returnValue: Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                  _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> getPopularSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularSeries, []),
              returnValue: Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                  _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> getTopRatedSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedSeries, []),
              returnValue: Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                  _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);

  @override
  Future<i2.Either<i8.Failure, i10.SeriesDetail>> getSeriesDetail(int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesDetail, [id]),
              returnValue:
                  Future<i2.Either<i8.Failure, i10.SeriesDetail>>.value(
                      _FakeEither<i8.Failure, i10.SeriesDetail>()))
          as i7.Future<i2.Either<i8.Failure, i10.SeriesDetail>>);

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> getSeriesRecommendations(
          int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesRecommendations, [id]),
              returnValue: Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                  _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> searchSeries(String query) =>
      (super.noSuchMethod(Invocation.method(#searchSeries, [query]),
              returnValue: Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                  _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);

  @override
  Future<i2.Either<i8.Failure, String>> saveWatchlistSeries(
          i10.SeriesDetail movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlistSeries, [movie]),
              returnValue: Future<i2.Either<i8.Failure, String>>.value(
                  _FakeEither<i8.Failure, String>()))
          as i7.Future<i2.Either<i8.Failure, String>>);

  @override
  Future<i2.Either<i8.Failure, String>> removeWatchlistSeries(
          i10.SeriesDetail movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistSeries, [movie]),
              returnValue: Future<i2.Either<i8.Failure, String>>.value(
                  _FakeEither<i8.Failure, String>()))
          as i7.Future<i2.Either<i8.Failure, String>>);

  @override
  Future<bool> isAddedToWatchlistTv(int id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlistTv, [id]),
          returnValue: Future<bool>.value(false)) as i7.Future<bool>);

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> getWatchlistSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistSeries, []),
              returnValue: Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                  _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);
}
