import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/home/get_home_info.dart';
import 'package:movie_time/domain/home/home_info.dart';
import 'package:movie_time/domain/home/home_info_repository.dart';
import 'package:movie_time/domain/home/movie_list.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';

class MockHomeInfoRepository extends Mock implements HomeInfoRepository {}

class TestFailure extends Failure {}

void main() {
  GetHomeInfo usecase;
  MockHomeInfoRepository mockHomeInfoRepository;

  setUp(() {
    mockHomeInfoRepository = MockHomeInfoRepository();
    usecase = GetHomeInfo(mockHomeInfoRepository);
  });

  final trendingMovies = MovieList<TrendingMovieInfo>(
    listName: "Trending",
    movieList: [
      TrendingMovieInfo(
        id: 299536,
        title: "Avengers: Infinity War",
        genres: [GenreUtil.genreIdAndName[28]],
        posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
      ),
    ],
  );

  final genreId = 28;
  final genreMovies = MovieList<ShortMovieInfo>(
    listName: GenreUtil.genreIdAndName[genreId],
    movieList: [
      ShortMovieInfo(
        id: 338762,
        title: "Bloodshot",
        posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
      ),
    ],
  );

  group("successful repository calls", () {
    void setUpSuccess() {
      when(mockHomeInfoRepository.getTrendingMovies())
          .thenAnswer((_) async => Right(trendingMovies));
      when(mockHomeInfoRepository.getMoviesByGenre(any))
          .thenAnswer((_) async => Right(genreMovies));
    }

    test("should get trending movies from the repository", () async {
      // arrange
      setUpSuccess();
      // act
      await usecase(NoParams());
      // assert
      verify(mockHomeInfoRepository.getTrendingMovies());
    });

    test("should get movies for a genre from the repository", () async {
      // arrange
      setUpSuccess();
      // act
      await usecase(NoParams());
      // assert
      verify(mockHomeInfoRepository.getMoviesByGenre(genreId));
    });
  });

  group("failures", () {
    final failure = TestFailure();

    test("get failure when trending movies are not found", () async {
      // arrange
      when(mockHomeInfoRepository.getTrendingMovies())
          .thenAnswer((realInvocation) async => Left(failure));
      when(mockHomeInfoRepository.getMoviesByGenre(any))
          .thenAnswer((_) async => Right(genreMovies));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Left(failure));
    });

    test("get failure when genre movies are not found", () async {
      // arrange
      when(mockHomeInfoRepository.getMoviesByGenre(any))
          .thenAnswer((_) async => Left(failure));
      when(mockHomeInfoRepository.getTrendingMovies())
          .thenAnswer((_) async => Right(trendingMovies));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Left(failure));
    });
  });

}
