import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movieflutter/data/models/series_model.dart';
import 'package:movieflutter/data/models/series_response.dart';

import '../../../json_reader.dart';

void main() {
  final tSeriesModel = SeriesModel(
      adult: false,
      backdropPath: "/backdrop_path.jpg",
      genreIds: [35, 10766, 10759],
      id:222289,
      originCountry: ["BR"],
      originalLanguage: "id",
      originalName: "Famili",
      overview: "Five Half Sibling",
      popularity: 1.1,
      posterPath: "/poster_path.jpg",
      firstAirDate: DateTime.parse("2024-03-04"),
      name: "Le Família",
      voteAverage: 6.071,
      voteCount: 7);
  final tSeriesResponseModel = SeriesResponse(
      page: 1,
      totalResults: 276,
      totalPages: 14,
      results: <SeriesModel>[tSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/series/now_playing.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "page": 1,
        "results": [
          {
            "adult": false,
            "backdrop_path": "/backdrop_path.jpg",
            "genre_ids": [35, 10766, 10759],
            "id": 222289,
            "origin_country": ["BR"],
            "original_language": "id",
            "original_name": "Famili",
            "overview": "Five Half Sibling",
            "popularity": 1.1,
            "poster_path": "/poster_path.jpg",
            "first_air_date": "2024-03-04",
            "name": "Le Família",
            "vote_average": 6.071,
            "vote_count": 7
          }
        ],
        "total_pages": 14,
        "total_results": 276
      };
      expect(result, expectedJsonMap);
    });
  });
}
