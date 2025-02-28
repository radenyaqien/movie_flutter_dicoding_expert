import 'package:common/data/datasources/db/database_helper.dart';
import 'package:common/data/datasources/movie_local_data_source.dart';
import 'package:common/data/datasources/movie_remote_data_source.dart';
import 'package:domain/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
