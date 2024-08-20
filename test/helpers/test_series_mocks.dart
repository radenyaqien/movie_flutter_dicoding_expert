import 'dart:async' as _i7;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movieflutter/common/failure.dart' as _i8;
import 'package:movieflutter/data/datasources/series/series_local_data_source.dart'
    as _i13;
import 'package:movieflutter/data/datasources/series/series_remote_data_source.dart'
    as _i11;
import 'package:movieflutter/data/models/detail_series_response.dart' as _i3;
import 'package:movieflutter/data/models/series_model.dart' as _i12;
import 'package:movieflutter/data/models/series_table.dart' as _i14;
import 'package:movieflutter/domain/entities/series.dart' as _i9;
import 'package:movieflutter/domain/entities/series/tv_detail.dart' as _i10;
import 'package:movieflutter/domain/repositories/series_repository.dart' as _i6;

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeSeriesDetailResponse extends _i1.Fake
    implements _i3.DetailSeriesResponse {}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRepository extends _i1.Mock implements _i6.SeriesRepository {
  MockSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Future<_i2.Either<_i8.Failure, List<_i9.Series>>> getNowPlayingSeries() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i9.Series>>>.value(
                      _FakeEither<_i8.Failure, List<_i9.Series>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Series>>>);

  @override
  Future<_i2.Either<_i8.Failure, List<_i9.Series>>> getPopularSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i9.Series>>>.value(
                      _FakeEither<_i8.Failure, List<_i9.Series>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Series>>>);

  @override
  Future<_i2.Either<_i8.Failure, List<_i9.Series>>> getTopRatedSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i9.Series>>>.value(
                      _FakeEither<_i8.Failure, List<_i9.Series>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Series>>>);

  @override
  Future<_i2.Either<_i8.Failure, _i10.SeriesDetail>> getSeriesDetail(int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, _i10.SeriesDetail>>.value(
                      _FakeEither<_i8.Failure, _i10.SeriesDetail>()))
          as _i7.Future<_i2.Either<_i8.Failure, _i10.SeriesDetail>>);

  @override
  Future<_i2.Either<_i8.Failure, List<_i9.Series>>> getSeriesRecommendations(
          int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesRecommendations, [id]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i9.Series>>>.value(
                      _FakeEither<_i8.Failure, List<_i9.Series>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Series>>>);

  @override
  Future<_i2.Either<_i8.Failure, List<_i9.Series>>> searchSeries(
          String query) =>
      (super.noSuchMethod(Invocation.method(#searchSeries, [query]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i9.Series>>>.value(
                      _FakeEither<_i8.Failure, List<_i9.Series>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Series>>>);

  @override
  Future<_i2.Either<_i8.Failure, String>> saveWatchlistSeries(
          _i10.SeriesDetail movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlistSeries, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);

  @override
  Future<_i2.Either<_i8.Failure, String>> removeWatchlistSeries(
          _i10.SeriesDetail movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistSeries, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);

  @override
  Future<bool> isAddedToWatchlistTv(int id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlistTv, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);

  @override
  Future<_i2.Either<_i8.Failure, List<_i9.Series>>> getWatchlistSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i9.Series>>>.value(
                      _FakeEither<_i8.Failure, List<_i9.Series>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Series>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRemoteDataSource extends _i1.Mock
    implements _i11.SeriesRemoteDataSource {
  MockSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.SeriesModel>> getNowPlayingSeries() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingSeries, []),
              returnValue:
                  Future<List<_i12.SeriesModel>>.value(<_i12.SeriesModel>[]))
          as _i7.Future<List<_i12.SeriesModel>>);

  @override
  _i7.Future<List<_i12.SeriesModel>> searchSeries(String query) =>
      (super.noSuchMethod(Invocation.method(#searchSeries, [query]),
              returnValue:
                  Future<List<_i12.SeriesModel>>.value(<_i12.SeriesModel>[]))
          as _i7.Future<List<_i12.SeriesModel>>);

  @override
  _i7.Future<List<_i12.SeriesModel>> getSeriesRecommendations(int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesRecommendations, [id]),
              returnValue:
                  Future<List<_i12.SeriesModel>>.value(<_i12.SeriesModel>[]))
          as _i7.Future<List<_i12.SeriesModel>>);

  @override
  _i7.Future<_i3.DetailSeriesResponse> getSeriesDetail(int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesDetail, [id]),
              returnValue: Future<_i3.DetailSeriesResponse>.value(
                  _FakeSeriesDetailResponse()))
          as _i7.Future<_i3.DetailSeriesResponse>);

  @override
  _i7.Future<List<_i12.SeriesModel>> getTopRatedSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedSeries, []),
              returnValue:
                  Future<List<_i12.SeriesModel>>.value(<_i12.SeriesModel>[]))
          as _i7.Future<List<_i12.SeriesModel>>);

  @override
  _i7.Future<List<_i12.SeriesModel>> getPopularSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularSeries, []),
              returnValue:
                  Future<List<_i12.SeriesModel>>.value(<_i12.SeriesModel>[]))
          as _i7.Future<List<_i12.SeriesModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesLocalDataSource extends _i1.Mock
    implements _i13.SeriesLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlistSeries(_i14.SeriesTable movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);

  @override
  _i7.Future<List<_i14.SeriesTable>> getWatchlistSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistSeries, []),
              returnValue:
                  Future<List<_i14.SeriesTable>>.value(<_i14.SeriesTable>[]))
          as _i7.Future<List<_i14.SeriesTable>>);

  @override
  _i7.Future<_i14.SeriesTable?> getSeriesById(int id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesById, [id]),
              returnValue: Future<_i14.SeriesTable?>.value())
          as _i7.Future<_i14.SeriesTable?>);

  @override
  _i7.Future<String> removeWatchlistSeries(_i14.SeriesTable series) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistSeries, [series]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
}
