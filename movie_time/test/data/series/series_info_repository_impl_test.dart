import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/series/season_info_model.dart';
import 'package:movie_time/data/series/series_info_model.dart';
import 'package:movie_time/data/series/series_info_remote_data_source.dart';
import 'package:movie_time/data/series/series_info_repository_impl.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/series/season_info.dart';
import 'package:movie_time/domain/series/series_info.dart';

import '../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements SeriesInfoRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  SeriesInfoRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SeriesInfoRepositoryImpl(
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

  group("getSeriesById", () {
    final seriesId = 1399;
    final seriesInfoModel =
        SeriesInfoModel.fromJson(json.decode(fixture("series.json")));
    final SeriesInfo seriesInfo = seriesInfoModel;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getSeriesById(seriesId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        "should return remote data when the call to remote data source is successful",
        () async {
          // arrange
          when(mockRemoteDataSource.getSeriesById(seriesId))
              .thenAnswer((_) async => seriesInfoModel);
          // act
          final result = await repository.getSeriesById(seriesId);
          // assert
          verify(mockRemoteDataSource.getSeriesById(seriesId));
          expect(result, equals(Right(seriesInfo)));
        },
      );

      test(
        "should return server failure when the call to remote data source is unsuccesful",
        () async {
          // arrange
          when(mockRemoteDataSource.getSeriesById(seriesId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getSeriesById(seriesId);
          // assert
          verify(mockRemoteDataSource.getSeriesById(seriesId));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        "should return ConnectionFailure when device is offline",
        () async {
          final result = await repository.getSeriesById(seriesId);
          expect(result, equals(Left(ConnectionFailure())));
        },
      );
    });
  });

  group("getSeriesSeasonByNumber", () {
    final seriesId = 1399;
    final seasonNumber = 1;
    final seasonInfoModel =
        SeasonInfoModel.fromJson(json.decode(fixture("season.json")));
    final SeasonInfo seasonInfo = seasonInfoModel;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getSeriesSeasonByNumber(seriesId, seasonNumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        "should return remote data when the call to remote data source is successful",
        () async {
          // arrange
          when(mockRemoteDataSource.getSeriesSeasonByNumber(
                  seriesId, seasonNumber))
              .thenAnswer((_) async => seasonInfoModel);
          // act
          final result =
              await repository.getSeriesSeasonByNumber(seriesId, seasonNumber);
          // assert
          verify(mockRemoteDataSource.getSeriesSeasonByNumber(
              seriesId, seasonNumber));
          expect(result, equals(Right(seasonInfo)));
        },
      );

      test(
        "should return server failure when the call to remote data source is unsuccesful",
        () async {
          // arrange
          when(mockRemoteDataSource.getSeriesSeasonByNumber(
                  seriesId, seasonNumber))
              .thenThrow(ServerException());
          // act
          final result =
              await repository.getSeriesSeasonByNumber(seriesId, seasonNumber);
          // assert
          verify(mockRemoteDataSource.getSeriesSeasonByNumber(
              seriesId, seasonNumber));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        "should return ConnectionFailure when device is offline",
        () async {
          final result =
              await repository.getSeriesSeasonByNumber(seriesId, seasonNumber);
          expect(result, equals(Left(ConnectionFailure())));
        },
      );
    });
  });
}
