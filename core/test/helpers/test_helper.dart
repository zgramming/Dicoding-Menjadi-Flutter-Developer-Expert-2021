import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

import 'package:core/src/data/datasources/db/database_helper.dart';
import 'package:core/src/data/datasources/movie_local_data_source.dart';
import 'package:core/src/data/datasources/movie_remote_data_source.dart';
import 'package:core/src/data/datasources/tv_local_data_source.dart';
import 'package:core/src/data/datasources/tv_remote_data_source.dart';
import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:core/src/domain/repositories/tv_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,

  /// TV Resource
  TVRepository,
  TVRemoteDataSource,
  TVLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
