import 'dart:async' as i7;

import 'package:common/data/datasources/series/series_local_data_source.dart'
    as i13;
import 'package:common/data/datasources/series/series_remote_data_source.dart'
    as i11;
import 'package:common/data/models/detail_series_response.dart' as i3;
import 'package:common/data/models/series_model.dart' as i12;
import 'package:common/data/models/series_table.dart' as i14;
import 'package:mockito/mockito.dart' as i1;

class _FakeSeriesDetailResponse extends i1.Fake
    implements i3.DetailSeriesResponse {}

///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRemoteDataSource extends i1.Mock
    implements i11.SeriesRemoteDataSource {
  MockSeriesRemoteDataSource() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<List<i12.SeriesModel>> getNowPlayingSeries() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingSeries, []),
          returnValue: Future<List<i12.SeriesModel>>.value(<i12.SeriesModel>[]))
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
  i7.Future<List<i12.SeriesModel>> getTopRatedSeries() => (super.noSuchMethod(
          Invocation.method(#getTopRatedSeries, []),
          returnValue: Future<List<i12.SeriesModel>>.value(<i12.SeriesModel>[]))
      as i7.Future<List<i12.SeriesModel>>);

  @override
  i7.Future<List<i12.SeriesModel>> getPopularSeries() => (super.noSuchMethod(
          Invocation.method(#getPopularSeries, []),
          returnValue: Future<List<i12.SeriesModel>>.value(<i12.SeriesModel>[]))
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
  i7.Future<List<i14.SeriesTable>> getWatchlistSeries() => (super.noSuchMethod(
          Invocation.method(#getWatchlistSeries, []),
          returnValue: Future<List<i14.SeriesTable>>.value(<i14.SeriesTable>[]))
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
