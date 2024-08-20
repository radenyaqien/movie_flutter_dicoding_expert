import 'package:movieflutter/data/models/series_table.dart';
import 'package:movieflutter/domain/entities/genre.dart';
import 'package:movieflutter/domain/entities/movie.dart';
import 'package:movieflutter/domain/entities/movie_detail.dart';
import 'package:movieflutter/domain/entities/series.dart';

final testMovie = Series(
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

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesTable = SeriesTable(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
