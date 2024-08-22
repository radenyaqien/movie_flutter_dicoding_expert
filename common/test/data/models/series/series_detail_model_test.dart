import 'dart:convert';

import 'package:common/data/models/detail_series_response.dart';
import 'package:domain/entities/genre.dart';
import 'package:domain/entities/season.dart';
import 'package:domain/entities/series/production_company.dart';
import 'package:domain/entities/series/series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tSeriesDetailModel = DetailSeriesResponse.fromJson(
      json.decode(readJson('dummy_data/series/detail.json')));

  final tSeriesDetail = SeriesDetail(
      backdropPath: "/backdrop_path.jpg",
      genres: const [Genre(id: 16, name: "Animation")],
      homepage: "http://www.com",
      id: 60625,
      inProduction: true,
      languages: const ["en"],
      lastAirDate: DateTime.tryParse("2023-12-17"),
      name: "Rick and Morty",
      numberOfEpisodes: 71,
      numberOfSeasons: 7,
      originCountry: const ["US"],
      originalLanguage: "en",
      originalName: "Rick and Morty",
      overview: "Rick is a ",
      popularity: 408.253,
      posterPath: "/poster_path.jpg",
      productionCompanies: const [
        ProductionCompany(
            id: 6760,
            logo_path: "/logo_path.png",
            name: "Williams Street",
            origin_country: "US")
      ],
      seasons: [
        Season(
          airDate: DateTime.tryParse("2016-10-25"),
          episodeCount: 35,
          id: 106178,
          name: "Specials",
          overview: "",
          posterPath: "poster_path.jpg",
          seasonNumber: 0,
        )
      ],
      status: "Returning Series",
      tagline: "Science makes sense, family doesn't.",
      type: "Scripted",
      voteAverage: 8.697,
      voteCount: 9595);

  test('should be a subclass of Series Detail entity', () async {
    final result = tSeriesDetailModel.toEntity();
    expect(result, tSeriesDetail);
  });
}
