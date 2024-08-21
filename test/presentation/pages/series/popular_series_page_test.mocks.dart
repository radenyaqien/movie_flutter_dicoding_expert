// Mocks generated by Mockito 5.0.8 from annotations
// in movieflutter/test/presentation/pages/popular_movies_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as i6;
import 'dart:ui' as i7;

import 'package:movieflutter/common/state_enum.dart' as i4;
import 'package:movieflutter/domain/entities/series/series.dart' as i5;
import 'package:movieflutter/domain/usecases/series/get_popular_series.dart' as i2;
import 'package:movieflutter/presentation/provider/series/popular_series_notifier.dart'
as i3;
import 'package:mockito/mockito.dart' as i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGetPopularSeries extends i1.Fake implements i2.GetPopularSeries {}

/// A class which mocks [PopularMoviesNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularSeriesNotifier extends i1.Mock
    implements i3.PopularSeriesNotifier {
  MockPopularSeriesNotifier() {
    i1.throwOnMissingStub(this);
  }


  @override
  i4.RequestState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: i4.RequestState.Empty) as i4.RequestState);


  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
      as String);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
      as bool);

  @override
  void addListener(i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);

  @override
  void removeListener(i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);

  @override
  void dispose() =>
      super.noSuchMethod(Invocation.method(#dispose, []),
          returnValueForMissingStub: null);

  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);

  @override
  i2.GetPopularSeries get getPopularSeries =>
      (super.noSuchMethod(Invocation.getter(#getPopularSeries),
          returnValue: _FakeGetPopularSeries()) as i2.GetPopularSeries);

  @override
  List<i5.Series> get series =>
      (super.noSuchMethod(Invocation.getter(#series),
          returnValue: <i5.Series>[]) as List<i5.Series>);

  @override
  Future<void> fetchPopularSeries() =>
      (super.noSuchMethod(Invocation.method(#fetchPopularSeries, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as i6.Future<void>);
}
