import 'package:movieflutter/data/models/movie_model.dart';
import 'package:movieflutter/data/models/series_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movieflutter/domain/entities/series.dart';

void main() {
  final tSeriesModel = SeriesModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    firstAirDate: DateTime.parse("2004-09-01"),
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originCountry: [
      "US"
    ],
    originalLanguage: "en",
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeries = Series(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    firstAirDate: DateTime.parse("2004-09-01"),
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originCountry: [
      "US"
    ],
    originalLanguage: "en",
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Series entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
