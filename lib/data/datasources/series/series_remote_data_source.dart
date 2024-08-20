import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflutter/common/exception.dart';
import 'package:movieflutter/data/datasources/constant.dart';
import 'package:movieflutter/data/models/series_model.dart';
import 'package:movieflutter/data/models/series_response.dart';

import '../../models/detail_series_response.dart';

abstract class SeriesRemoteDataSource {
  Future<List<SeriesModel>> getNowPlayingSeries();

  Future<List<SeriesModel>> getPopularSeries();

  Future<List<SeriesModel>> getTopRatedSeries();

  Future<DetailSeriesResponse> getSeriesDetail(int id);

  Future<List<SeriesModel>> getSeriesRecommendations(int id);

  Future<List<SeriesModel>> searchSeries(String query);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  final http.Client client;

  SeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SeriesModel>> getNowPlayingSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailSeriesResponse> getSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return DetailSeriesResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    print("detail rec" + response.body);
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
