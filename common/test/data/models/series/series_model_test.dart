import 'package:common/data/models/series_model.dart';
import 'package:domain/entities/series/series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesModel = SeriesModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    firstAirDate: DateTime.parse("2004-09-01"),
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originCountry: const [
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
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    firstAirDate: DateTime.parse("2004-09-01"),
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originCountry: const [
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
