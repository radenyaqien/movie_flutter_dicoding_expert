import 'dart:convert';

import 'package:common/common/exception.dart';
import 'package:common/data/datasources/series/series_remote_data_source.dart';
import 'package:common/data/models/detail_series_response.dart';
import 'package:common/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';import '../../helpers/test_movie_source_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series/now_playing.json')))
        .results;

    test('should return list of Tv Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series/popular.json')))
        .results;

    test('should return list of tv Series when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/series/popular.json'), 200));
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, tSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series/top_rated.json')))
        .results;

    test('should return list of tv Series when response code is 200 ',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/series/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, tSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series detail', () {
    const tId = 1;
    final tMovieDetail = DetailSeriesResponse.fromJson(
        json.decode(readJson('dummy_data/series/detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/series/detail.json'), 200));
      // act
      final result = await dataSource.getSeriesDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series/recommendations.json')))
        .results;
    const tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series/recommendations.json'), 200));
      // act
      final result = await dataSource.getSeriesRecommendations(tId);
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv Series', () {
    final tSearchResult = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series/search.json')))
        .results;
    const tQuery = 'Rick and Morty';

    test('should return list of tv Series when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/series/search.json'), 200));
      // act
      final result = await dataSource.searchSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
