import 'package:movieflutter/data/models/series_table.dart';
import 'package:movieflutter/domain/entities/genre.dart';
import 'package:movieflutter/domain/entities/movie.dart';
import 'package:movieflutter/domain/entities/movie_detail.dart';
import 'package:movieflutter/domain/entities/series.dart';
import 'package:movieflutter/domain/entities/series/tv_detail.dart';

final testSeries = Series(
    adult: false,
    backdropPath: "/uCY1j1YqfDWRbbS7hJwd9szX1sJ.jpg",
    genreIds: [10766, 18, 35],
    id: 237480,
    originCountry: ["BR"],
    originalLanguage: "pt",
    originalName: "No Rancho Fundo",
    overview: "",
    popularity: 2860.036,
    posterPath: "/eONkvEahSQJan1HTzWJKjvaMe29.jpg",
    firstAirDate: DateTime.parse("2024-04-15"),
    name: "No Rancho Fundo",
    voteAverage: 4.912,
    voteCount: 18);

final testSeriesList = [testSeries];

final testSeriesDetail = SeriesDetail(
  homepage: "homepage",
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  originalLanguage: "en",
  originCountry: ["us"],
  overview: 'overview',
  posterPath: 'posterPath',
  numberOfEpisodes: 20,
  numberOfSeasons: 1,
  inProduction: true,
  languages: ["id"],
  popularity: 6.5,
  seasons: [],
  tagline: "tagline",
  status: "status",
  type: "type",
  productionCompanies: [],
  lastAirDate: DateTime.parse("2024-01-01"),
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistSeries = Series.watchList(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesTable = SeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
