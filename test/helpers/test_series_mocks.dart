import 'dart:async' as i7;

import 'package:dartz/dartz.dart' as i2;
import 'package:mockito/mockito.dart' as i1;
import 'package:movieflutter/common/failure.dart' as i8;
import 'package:movieflutter/data/datasources/series/series_local_data_source.dart'
    as i13;
import 'package:movieflutter/data/datasources/series/series_remote_data_source.dart'
    as i11;
import 'package:movieflutter/data/models/detail_series_response.dart' as i3;
import 'package:movieflutter/data/models/series_model.dart' as i12;
import 'package:movieflutter/data/models/series_table.dart' as i14;
import 'package:movieflutter/domain/entities/series/series.dart' as i9;
import 'package:movieflutter/domain/entities/series/series_detail.dart' as i10;
import 'package:movieflutter/domain/repositories/series_repository.dart' as i6;

class _FakeEither<L, R> extends i1.Fake implements i2.Either<L, R> {}

class _FakeSeriesDetailResponse extends i1.Fake
    implements i3.DetailSeriesResponse {}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRepository extends i1.Mock implements i6.SeriesRepository {
  MockSeriesRepository() {
    i1.throwOnMissingStub(this);
  }

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> getNowPlayingSeries() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingSeries, []),
              returnValue:
                  Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                      _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> getPopularSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularSeries, []),
              returnValue:
                  Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                      _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> getTopRatedSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedSeries, []),
              returnValue:
                  Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
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
              returnValue:
                  Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                      _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);

  @override
  Future<i2.Either<i8.Failure, List<i9.Series>>> searchSeries(
          String query) =>
      (super.noSuchMethod(Invocation.method(#searchSeries, [query]),
              returnValue:
                  Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
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
              returnValue:
                  Future<i2.Either<i8.Failure, List<i9.Series>>>.value(
                      _FakeEither<i8.Failure, List<i9.Series>>()))
          as i7.Future<i2.Either<i8.Failure, List<i9.Series>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRemoteDataSource extends i1.Mock
    implements i11.SeriesRemoteDataSource {
  MockSeriesRemoteDataSource() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<List<i12.SeriesModel>> getNowPlayingSeries() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingSeries, []),
              returnValue:
                  Future<List<i12.SeriesModel>>.value(<i12.SeriesModel>[]))
          as i7.Future<List<i12.SeriesModel>>);

  @override
  i7.Future<List<i12.SeriesModel>> searchSeries(String query) =>
      (super.noSuchMethod(Invocation.method(#searchSeries, [query]),
              returnValue:
                  Future<List<i12.SeriesModel>>.value(<i12.SeriesModel>[]))
          as i7.Future<List<i12.SeriesModel>>);

  @override
  i7.Future<List<i12.SeriesModel>> getSeriesRecommendations(int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesRecommendations, [id]),
              returnValue:
                  Future<List<i12.SeriesModel>>.value(<i12.SeriesModel>[]))
          as i7.Future<List<i12.SeriesModel>>);

  @override
  i7.Future<i3.DetailSeriesResponse> getSeriesDetail(int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesDetail, [id]),
              returnValue: Future<i3.DetailSeriesResponse>.value(
                  _FakeSeriesDetailResponse()))
          as i7.Future<i3.DetailSeriesResponse>);

  @override
  i7.Future<List<i12.SeriesModel>> getTopRatedSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedSeries, []),
              returnValue:
                  Future<List<i12.SeriesModel>>.value(<i12.SeriesModel>[]))
          as i7.Future<List<i12.SeriesModel>>);

  @override
  i7.Future<List<i12.SeriesModel>> getPopularSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularSeries, []),
              returnValue:
                  Future<List<i12.SeriesModel>>.value(<i12.SeriesModel>[]))
          as i7.Future<List<i12.SeriesModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesLocalDataSource extends i1.Mock
    implements i13.SeriesLocalDataSource {
  MockMovieLocalDataSource() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<String> insertWatchlistSeries(i14.SeriesTable movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as i7.Future<String>);

  @override
  i7.Future<List<i14.SeriesTable>> getWatchlistSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistSeries, []),
              returnValue:
                  Future<List<i14.SeriesTable>>.value(<i14.SeriesTable>[]))
          as i7.Future<List<i14.SeriesTable>>);

  @override
  i7.Future<i14.SeriesTable?> getSeriesById(int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesById, [id]),
              returnValue: Future<i14.SeriesTable?>.value())
          as i7.Future<i14.SeriesTable?>);

  @override
  i7.Future<String> removeWatchlistSeries(i14.SeriesTable series) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistSeries, [series]),
          returnValue: Future<String>.value('')) as i7.Future<String>);
}
