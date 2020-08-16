import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/home/home_info_remote_datasource.dart';
import 'package:movie_time/data/home/media_list_model.dart';
import 'package:matcher/matcher.dart';
import 'package:movie_time/domain/core/genre_utils.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  HomeInfoRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = HomeInfoRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String jsonFileName) {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(fixture(jsonFileName), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));
  }

  group("getTrendingMovies", () {
    final fixtureName = "trending_movie_list.json";

    final trendingMovieListModel = MediaListModel.fromJson(
        json.decode(fixture(fixtureName)), "Trending", 10);

    test(
        "should perform GET request on a URL with 'trending/movie/day' being at the endponint",
        () {
      // arrange
      setUpMockHttpClientSuccess200(fixtureName);
      // act
      dataSource.getTrendingMovies();
      // assert
      verify(mockHttpClient.get(
        "https://api.themoviedb.org/3/trending/movie/day?api_key=$API_KEY",
      ));
    });

    test(
      "should return MovieListModel for trending movies when the response code is 200(success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200(fixtureName);
        // act
        final result = await dataSource.getTrendingMovies();
        // assert
        expect(result, equals(trendingMovieListModel));
      },
    );

    test(
        "should throw a ServerException when the response code is 404 or other",
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getTrendingMovies;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group("getGenreMovies", () {
    final fixtureName = "short_movie_list.json";
    final genreId = GenreUtil.action;

    final genreMovieListModel = MediaListModel.fromJson(
        json.decode(fixture(fixtureName)),
        GenreUtil.genreIdAndName[genreId],
        10);

    test(
        "should perform GET request on a URL with 'discover/with_genres' being at the endponint",
        () {
      // arrange
      setUpMockHttpClientSuccess200(fixtureName);
      // act
      dataSource.getMoviesByGenre(genreId);
      // assert
      verify(mockHttpClient.get(
        "https://api.themoviedb.org/3/discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genreId",
      ));
    });

    test(
      "should return MovieListModel for genre movies when the response code is 200(success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200(fixtureName);
        // act
        final result = await dataSource.getMoviesByGenre(genreId);
        // assert
        expect(result, equals(genreMovieListModel));
      },
    );

    test(
        "should throw a ServerException when the response code is 404 or other",
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getMoviesByGenre;
      // assert
      expect(() => call(genreId), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group("getTrendingSeries", () {
    final fixtureName = "trending_series_list.json";

    final trendingSeriesListModel = MediaListModel.fromJson(
        json.decode(fixture(fixtureName)), "Trending", 10);

    test(
        "should perform GET request on a URL with 'trending/tv/day' being at the endponint",
        () {
      // arrange
      setUpMockHttpClientSuccess200(fixtureName);
      // act
      dataSource.getTrendingSeries();
      // assert
      verify(mockHttpClient.get(
          "https://api.themoviedb.org/3/trending/tv/day?api_key=$API_KEY"));
    });

    test(
      "should return MediaListModel for trending series when the response code is 200(success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200(fixtureName);
        // act
        final result = await dataSource.getTrendingSeries();
        // assert
        expect(result, equals(trendingSeriesListModel));
      },
    );

    test(
        "should throw a ServerException when the response code is 404 or other",
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getTrendingSeries;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group("getGenreSeries", () {
    final fixtureName = "short_series_list.json";
    final genreId = GenreUtil.action;

    final genreSeriesListModel = MediaListModel.fromJson(
        json.decode(fixture(fixtureName)),
        GenreUtil.genreIdAndName[genreId],
        10);

    test(
        "should perform GET request on a URL with 'discover/with_genres' being at the endponint",
        () {
      // arrange
      setUpMockHttpClientSuccess200(fixtureName);
      // act
      dataSource.getSeriesByGenre(genreId);
      // assert
      verify(mockHttpClient.get(
        "https://api.themoviedb.org/3/discover/tv?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genreId",
      ));
    });

    test(
      "should return MediaListModel for genre series when the response code is 200(success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200(fixtureName);
        // act
        final result = await dataSource.getSeriesByGenre(genreId);
        // assert
        expect(result, equals(genreSeriesListModel));
      },
    );

    test(
        "should throw a ServerException when the response code is 404 or other",
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getSeriesByGenre;
      // assert
      expect(() => call(genreId), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
