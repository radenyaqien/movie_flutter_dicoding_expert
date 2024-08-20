import 'dart:async' as _i7;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movieflutter/data/datasources/series/series_local_data_source.dart'
    as _i13;
import 'package:movieflutter/data/datasources/series/series_remote_data_source.dart'
    as _i11;
import 'package:movieflutter/data/models/detail_series_response.dart' as _i3;
import 'package:movieflutter/data/models/series_model.dart' as _i12;
import 'package:movieflutter/data/models/series_table.dart' as _i14;

class _FakeSeriesDetailResponse extends _i1.Fake
    implements _i3.DetailSeriesResponse {}

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
