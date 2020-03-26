import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/core/platform/network_info.dart';
import 'package:movie_time/features/movie/data/datasources/movie_info_remote_data_source.dart';
import 'package:movie_time/features/movie/data/repositories/movie_info_repository_impl.dart';

class MockRemoteDataSource extends Mock implements MovieInfoRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MovieInfoRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieInfoRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
