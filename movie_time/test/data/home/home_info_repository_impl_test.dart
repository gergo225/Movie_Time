import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/home/home_info_remote_datasource.dart';
import 'package:movie_time/data/home/home_info_repository_impl.dart';
import 'package:movie_time/data/home/movie_list_model.dart';
import 'package:movie_time/data/home/short_movie_info_model.dart';
import 'package:movie_time/data/home/trending_movie_info_model.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/home/movie_list.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';

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
    final trendingMovieListModel = MovieListModel<TrendingMovieInfoModel>(
      listName: "Trending",
      movieList: [
        TrendingMovieInfoModel(
          id: 299536,
          title: "Avengers: Infinity War",
          genres: [GenreUtil.genreIdAndName[28]],
          posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
        ),
      ],
    );
    final MovieList<TrendingMovieInfo> trendingMovieList =
        trendingMovieListModel;

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
    final shortMovieListModel = MovieListModel<ShortMovieInfoModel>(
      listName: GenreUtil.genreIdAndName[genreId],
      movieList: [
        ShortMovieInfoModel(
          id: 338762,
          title: "Bloodshot",
          posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
        ),
      ],
    );
    final MovieList<ShortMovieInfo> shortMovieList = shortMovieListModel; 
    
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
        final result = await repository.getTrendingMovies();
        expect(result, equals(Left(ConnectionFailure())));
      });
    });

  });

}
