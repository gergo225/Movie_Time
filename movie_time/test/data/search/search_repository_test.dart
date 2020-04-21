import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/search/search_remote_data_source.dart';
import 'package:movie_time/data/search/search_repository_impl.dart';
import 'package:movie_time/data/search/search_result_model.dart';
import 'package:movie_time/data/search/searched_movie_info_model.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/search/search_result.dart';

class MockRemoteDataSource extends Mock implements SearchRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  SearchRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SearchRepositoryImpl(
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

  group("searchMovieByTitle", () {
    final movieTitle = "Avengers";
    final searchResultModel = SearchResultModel(results: [
    SearchedMovieInfoModel(
      title: "The Avengers",
      id: 24428,
      releaseYear: 2012,
      posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
      rating: 7.33,
    ),
  ]);
    final SearchResult searchResult = searchResultModel;

    test("should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.searchMovieByTitle(movieTitle);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        "should return remote data when the call to remote data source is successful",
        () async {
          // arrange
          when(mockRemoteDataSource.searchMovieByTitle(movieTitle))
              .thenAnswer((_) async => searchResultModel);
          // act
          final result = await repository.searchMovieByTitle(movieTitle);
          // assert
          verify(mockRemoteDataSource.searchMovieByTitle(movieTitle));
          expect(result, equals(Right(searchResult)));
        },
      );

      test(
        "should return server failure when the call to remote data source is unsuccesful",
        () async {
          // arrange
          when(mockRemoteDataSource.searchMovieByTitle(movieTitle))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchMovieByTitle(movieTitle);
          // assert
          verify(mockRemoteDataSource.searchMovieByTitle(movieTitle));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        "should return ConnectionFailure when device is offline",
        () async {
          final result = await repository.searchMovieByTitle(movieTitle);
          expect(result, equals(Left(ConnectionFailure())));
        },
      );
    });
  });

}
