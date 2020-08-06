import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/core/network/network_info.dart';
import 'package:movie_time/data/movie/movie_info_model.dart';
import 'package:movie_time/data/movie/movie_info_remote_data_source.dart';
import 'package:movie_time/data/movie/movie_info_repository_impl.dart';
import 'package:movie_time/data/core/short_actor_info_model.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/movie/movie_info.dart';

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
      id: 550,
      releaseDate: "1999-10-12",
      overview:
          "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
      backdropPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
      posterPath: null,
      rating: 7.8,
      genres: ["Drama"],
      runtimeInMinutes: 139,
      actors: [
        ShortActorInfoModel(
          id: 819,
          name: "Edward Norton",
          character: "The Narrator",
          profileImagePath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg",
        ),
        ShortActorInfoModel(
          id: 287,
          name: "Brad Pitt",
          character: "Tyler Durden",
          profileImagePath: "/tJiSUYst4ddIaz1zge2LqCtu9tw.jpg",
        ),
      ],
      trailerYouTubeKey: "BdJKm16Co6M",
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
}
