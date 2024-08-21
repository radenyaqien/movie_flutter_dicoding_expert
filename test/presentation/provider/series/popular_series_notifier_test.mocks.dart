// Mocks generated by Mockito 5.0.8 from annotations
// in movieflutter/test/presentation/provider/popular_movies_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as i5;

import 'package:dartz/dartz.dart' as i3;
import 'package:movieflutter/common/failure.dart' as i6;
import 'package:movieflutter/domain/entities/series/series.dart' as i7;
import 'package:movieflutter/domain/repositories/series_repository.dart' as i2;
import 'package:movieflutter/domain/usecases/series/get_popular_series.dart' as i4;
import 'package:mockito/mockito.dart' as i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeSeriesRepository extends i1.Fake implements i2.SeriesRepository {}

class _FakeEither<L, R> extends i1.Fake implements i3.Either<L, R> {}

/// A class which mocks [GetPopularMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularSeries extends i1.Mock implements i4.GetPopularSeries {
  MockGetPopularSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i7.Series>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<i3.Either<i6.Failure, List<i7.Series>>>.value(
              _FakeEither<i6.Failure, List<i7.Series>>())) as i5
          .Future<i3.Either<i6.Failure, List<i7.Series>>>);
}
