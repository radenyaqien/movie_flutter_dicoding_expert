// To parse this JSON data, do
//
//     final detailSeriesResponse = detailSeriesResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:movieflutter/data/models/genre_model.dart';
import 'package:movieflutter/data/models/production_company.dart';
import 'package:movieflutter/data/models/production_country.dart';
import 'package:movieflutter/data/models/season.dart';
import 'package:movieflutter/data/models/spoken_languange.dart';
import 'package:movieflutter/domain/entities/series/tv_detail.dart';

import 'created_by.dart';
import 'episode_to_air.dart';
import 'network.dart';

class DetailSeriesResponse extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<int> episodeRunTime;
  final DateTime? firstAirDate;
  final List<GenreModel>? genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;
  final TEpisodeToAir? lastEpisodeToAir;
  final String name;
  final TEpisodeToAir? nextEpisodeToAir;
  final List<Network>? networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String>? originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final List<Season>? seasons;
  final List<SpokenLanguage>? spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  DetailSeriesResponse({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory DetailSeriesResponse.fromJson(Map<String, dynamic> json) =>
      DetailSeriesResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedBy>.from(
            json["created_by"].map((x) => CreatedBy.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"] != null ? DateTime.parse(json["first_air_date"]) : null,
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"] != null
            ? DateTime.parse(json["last_air_date"])
            : null,
        lastEpisodeToAir: json["last_episode_to_air"] != null ? TEpisodeToAir.fromJson(json["last_episode_to_air"]): null ,
        name: json["name"],
        nextEpisodeToAir:json["next_episode_to_air"] !=null ? TEpisodeToAir.fromJson(json["next_episode_to_air"]) : null ,
        networks: List<Network>.from(
            json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"]
                .map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by":
            List<CreatedBy>.from((createdBy?.map((x) => x.toJson())) ?? []),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate?.day.toString().padLeft(2, '0')}",
        "genres": List<GenreModel>.from((genres?.map((x) => x.toJson())) ?? []),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from((languages?.map((x) => x)) ?? []),
        "last_air_date":
            "${lastAirDate?.year.toString().padLeft(4, '0')}-${lastAirDate?.month.toString().padLeft(2, '0')}-${lastAirDate?.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": lastEpisodeToAir?.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir?.toJson(),
        "networks":
            List<dynamic>.from((networks?.map((x) => x.toJson())) ?? []),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country":
            List<dynamic>.from((originCountry?.map((x) => x)) ?? []),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": List<ProductionCompany>.from(
            (productionCompanies?.map((x) => x.toJson())) ?? []),
        "production_countries": List<ProductionCountry>.from(
            (productionCountries?.map((x) => x.toJson())) ?? []),
        "seasons": List<dynamic>.from((seasons?.map((x) => x.toJson())) ?? []),
        "spoken_languages": List<SpokenLanguage>.from(
            (spokenLanguages?.map((x) => x.toJson())) ?? []),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  SeriesDetail toEntity() {
    return SeriesDetail(
      backdropPath: this.backdropPath,
      genres: this.genres?.map((genre) => genre.toEntity()).toList() ?? [],
      homepage: this.homepage,
      id: this.id,
      inProduction: this.inProduction,
      languages: this.languages ?? [],
      lastAirDate: this.lastAirDate,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      seasons: this.seasons?.map((s) => s.toEntity()).toList() ?? [],
      originCountry: this.originCountry ?? [],
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      productionCompanies: this.productionCompanies ?? [],
      status: this.status,
      tagline: this.tagline,
      type: this.type,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
