import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/home/home_info_remote_datasource.dart';
import 'package:movie_time/data/home/movie_list_model.dart';
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
    when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(fixture(jsonFileName), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));
  }

  group("getTrendingMovies", () {
    final fixtureName = "trending_movie_list.json";

    final trendingMovieListModel = MovieListModel.fromJson(
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
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
        },
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

    final genreMovieListModel = MovieListModel.fromJson(
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
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
        },
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
}
