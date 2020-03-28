import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/core/error/exception.dart';
import 'package:movie_time/core/error/failure.dart';
import 'package:movie_time/core/network/network_info.dart';
import 'package:movie_time/features/movie/data/datasources/movie_info_remote_data_source.dart';
import 'package:movie_time/features/movie/data/models/movie_info_model.dart';
import 'package:movie_time/features/movie/data/repositories/movie_info_repository_impl.dart';
import 'package:movie_time/features/movie/domain/entities/movie_info.dart';

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

  void runTestsOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group("getMovieById", () {
    final movieId = 550;
    final movieInfoModel = MovieInfoModel(
      title: "Fight Club",
      id: movieId,
      releaseDate: "1999-10-12",
      overview:
          "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
    );
    final MovieInfo movieInfo = movieInfoModel;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getMovieById(movieId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        "should return remote data when the call to remote data source is successful",
        () async {
          // arrange
          when(mockRemoteDataSource.getMovieById(movieId))
              .thenAnswer((_) async => movieInfoModel);
          // act
          final result = await repository.getMovieById(movieId);
          // assert
          verify(mockRemoteDataSource.getMovieById(movieId));
          expect(result, equals(Right(movieInfo)));
        },
      );

      test(
        "should return server failure when the call to remote data source is unsuccesful",
        () async {
          // arrange
          when(mockRemoteDataSource.getMovieById(movieId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getMovieById(movieId);
          // assert
          verify(mockRemoteDataSource.getMovieById(movieId));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        "should return ConnectionFailure when device is offline",
        () async {
          final result = await repository.getMovieById(movieId);
          expect(result, equals(Left(ConnectionFailure())));
        },
      );
    });
  });

  group("getLatestMovie", () {
    final movieId = 550;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getLatestMovieId();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        "should return remote data when the call to remote data source is successful",
        () async {
          // arrange
          when(mockRemoteDataSource.getLatestMovieId())
              .thenAnswer((_) async => movieId);
          // act
          final result = await repository.getLatestMovieId();
          // assert
          verify(mockRemoteDataSource.getLatestMovieId());
          expect(result, equals(Right(movieId)));
        },
      );

      test(
        "should return server failure when the call to remote data source is unsuccesful",
        () async {
          // arrange
          when(mockRemoteDataSource.getLatestMovieId())
              .thenThrow(ServerException());
          // act
          final result = await repository.getLatestMovieId();
          // assert
          verify(mockRemoteDataSource.getLatestMovieId());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        "should return ConnectionFailure when device is offline",
        () async {
          final result = await repository.getLatestMovieId();
          expect(result, equals(Left(ConnectionFailure())));
        },
      );
    });
  });
}
