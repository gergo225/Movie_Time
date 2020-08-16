import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/domain/core/failure.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/core/media_type.dart';
import 'package:movie_time/domain/core/usecase.dart';
import 'package:movie_time/domain/home/get_home_info.dart';
import 'package:movie_time/domain/home/home_info_repository.dart';
import 'package:movie_time/domain/home/media_list.dart';
import 'package:movie_time/domain/home/short_media_info.dart';

class MockHomeInfoRepository extends Mock implements HomeInfoRepository {}

class TestFailure extends Failure {}

void main() {
  GetHomeInfo usecase;
  MockHomeInfoRepository mockHomeInfoRepository;

  setUp(() {
    mockHomeInfoRepository = MockHomeInfoRepository();
    usecase = GetHomeInfo(mockHomeInfoRepository);
  });

  final trendingMovies = MediaList(
    listName: "Trending",
    mediaList: [
      ShortMediaInfo(
        id: 299536,
        title: "Avengers: Infinity War",
        posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
        mediaType: MediaType.movie,
      ),
    ],
  );

  final movieGenreId = 28;
  final genreMovies = MediaList(
    listName: GenreUtil.genreIdAndName[movieGenreId],
    mediaList: [
      ShortMediaInfo(
        id: 338762,
        title: "Bloodshot",
        posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
        mediaType: MediaType.movie,
      ),
    ],
  );

  final trendingSeries = MediaList(
    listName: "Trending",
    mediaList: [
      ShortMediaInfo(
        id: 1399,
        title: "Game of Thrones",
        posterPath: "/gwPSoYUHAKmdyVywgLpKKA4BjRr.jpg",
        mediaType: MediaType.tv,
      ),
    ],
  );

  final seriesGenreId = 28;
  final genreSeries = MediaList(
    listName: GenreUtil.genreIdAndName[seriesGenreId],
    mediaList: [
      ShortMediaInfo(
        title: "Avatar: The Last Airbender",
        id: 246,
        posterPath: "/42nUsJrcD4Us4SbILeYi7juBVJh.jpg",
        mediaType: MediaType.tv,
      ),
    ],
  );

  void setUpMovieSuccess() {
    when(mockHomeInfoRepository.getTrendingMovies())
        .thenAnswer((_) async => Right(trendingMovies));
    when(mockHomeInfoRepository.getMoviesByGenre(any))
        .thenAnswer((_) async => Right(genreMovies));
  }

  void setUpSeriesSuccess() {
    when(mockHomeInfoRepository.getTrendingSeries())
        .thenAnswer((_) async => Right(trendingSeries));
    when(mockHomeInfoRepository.getSeriesByGenre(any))
        .thenAnswer((_) async => Right(genreSeries));
  }

  test("should invoke all repository calls", () async {
    setUpMovieSuccess();
    setUpSeriesSuccess();

    await usecase(NoParams());

    verify(mockHomeInfoRepository.getTrendingMovies());
    verify(mockHomeInfoRepository.getTrendingSeries());
    verify(mockHomeInfoRepository.getMoviesByGenre(movieGenreId));
    verify(mockHomeInfoRepository.getSeriesByGenre(seriesGenreId));
  });

  group("failures", () {
    final failure = TestFailure();

    test("get failure when trending movies are not found", () async {
      // arrange
      setUpSeriesSuccess();
      when(mockHomeInfoRepository.getTrendingMovies())
          .thenAnswer((_) async => Left(failure));
      when(mockHomeInfoRepository.getMoviesByGenre(any))
          .thenAnswer((_) async => Right(genreMovies));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Left(failure));
    });

    test("get failure when genre movies are not found", () async {
      // arrange
      setUpSeriesSuccess();
      when(mockHomeInfoRepository.getMoviesByGenre(any))
          .thenAnswer((_) async => Left(failure));
      when(mockHomeInfoRepository.getTrendingMovies())
          .thenAnswer((_) async => Right(trendingMovies));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Left(failure));
    });
    test("get failure when trending series are not found", () async {
      // arrange
      setUpMovieSuccess();
      when(mockHomeInfoRepository.getTrendingSeries())
          .thenAnswer((_) async => Left(failure));
      when(mockHomeInfoRepository.getSeriesByGenre(any))
          .thenAnswer((_) async => Right(genreSeries));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Left(failure));
    });

    test("get failure when genre series are not found", () async {
      // arrange
      setUpMovieSuccess();
      when(mockHomeInfoRepository.getSeriesByGenre(any))
          .thenAnswer((_) async => Left(failure));
      when(mockHomeInfoRepository.getTrendingSeries())
          .thenAnswer((_) async => Right(trendingSeries));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Left(failure));
    });
  });
}
