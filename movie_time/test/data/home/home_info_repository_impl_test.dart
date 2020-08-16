import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/home/home_info_remote_datasource.dart';
import 'package:movie_time/data/home/home_info_repository_impl.dart';
import 'package:movie_time/data/home/media_list_model.dart';
import 'package:movie_time/data/home/short_media_info_model.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/home/media_list.dart';

import '../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockRemoteDataSource extends Mock implements HomeInfoRemoteDataSource {}

void main() {
  HomeInfoRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    repository = HomeInfoRepositoryImpl(
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

  group("getTrendingMovies", () {
    final trendingMovieListModel = MediaListModel(
      listName: "Trending",
      mediaList: [
        ShortMediaInfoModel.fromJson(
          json.decode(fixture("trending_movie.json")),
        ),
      ],
    );
    final MediaList trendingMovieList = trendingMovieListModel;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getTrendingMovies();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getTrendingMovies())
            .thenAnswer((_) async => trendingMovieListModel);
        // act
        final result = await repository.getTrendingMovies();
        // assert
        verify(mockRemoteDataSource.getTrendingMovies());
        expect(result, equals(Right(trendingMovieList)));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        // arrange
        when(mockRemoteDataSource.getTrendingMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTrendingMovies();
        // assert
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test("should return ConnectionFailure when device is offline", () async {
        // arrange
        final result = await repository.getTrendingMovies();
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });

  group("getMoviesByGenre", () {
    final genreId = GenreUtil.action;
    final shortMovieListModel = MediaListModel(
      listName: GenreUtil.genreIdAndName[genreId],
      mediaList: [
        ShortMediaInfoModel.fromJson(
          json.decode(fixture("short_movie.json")),
        ),
      ],
    );
    final MediaList shortMovieList = shortMovieListModel;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getTrendingMovies();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getMoviesByGenre(any))
            .thenAnswer((_) async => shortMovieListModel);
        // act
        final result = await repository.getMoviesByGenre(genreId);
        // assert
        verify(mockRemoteDataSource.getMoviesByGenre(genreId));
        expect(result, equals(Right(shortMovieList)));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        // arrange
        when(mockRemoteDataSource.getMoviesByGenre(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getMoviesByGenre(genreId);
        // assert
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test("should return ConnectionFailure when device is offline", () async {
        // arrange
        final result = await repository.getMoviesByGenre(genreId);
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });
  group("getTrendingSeries", () {
    final trendingSeriesListModel = MediaListModel(
      listName: "Trending",
      mediaList: [
        ShortMediaInfoModel.fromJson(
          json.decode(fixture("trending_series.json")),
        ),
      ],
    );
    final MediaList trendingSeriesList = trendingSeriesListModel;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getTrendingSeries();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getTrendingSeries())
            .thenAnswer((_) async => trendingSeriesListModel);
        // act
        final result = await repository.getTrendingSeries();
        // assert
        verify(mockRemoteDataSource.getTrendingSeries());
        expect(result, equals(Right(trendingSeriesList)));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        // arrange
        when(mockRemoteDataSource.getTrendingSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTrendingSeries();
        // assert
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test("should return ConnectionFailure when device is offline", () async {
        // arrange
        final result = await repository.getTrendingSeries();
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });

  group("getSeriesByGenre", () {
    final genreId = GenreUtil.action;
    final shortSeriesListModel = MediaListModel(
      listName: GenreUtil.genreIdAndName[genreId],
      mediaList: [
        ShortMediaInfoModel.fromJson(
          json.decode(fixture("short_series.json")),
        ),
      ],
    );
    final MediaList shortSeriesList = shortSeriesListModel;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getSeriesByGenre(genreId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getSeriesByGenre(any))
            .thenAnswer((_) async => shortSeriesListModel);
        // act
        final result = await repository.getSeriesByGenre(genreId);
        // assert
        verify(mockRemoteDataSource.getSeriesByGenre(genreId));
        expect(result, equals(Right(shortSeriesList)));
      });

      test(
          "should return server failure when the call to remote data source is unsuccessful",
          () async {
        // arrange
        when(mockRemoteDataSource.getSeriesByGenre(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getSeriesByGenre(genreId);
        // assert
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test("should return ConnectionFailure when device is offline", () async {
        // arrange
        final result = await repository.getSeriesByGenre(genreId);
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });
}
