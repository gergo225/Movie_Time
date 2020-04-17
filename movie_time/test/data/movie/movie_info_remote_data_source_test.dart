import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/movie/movie_info_model.dart';
import 'package:movie_time/data/movie/movie_info_remote_data_source.dart';
import 'package:matcher/matcher.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MovieInfoRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieInfoRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(fixture("movie.json"), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response("Somethings went wrong", 404));
  }

  group("getMovieById", () {
    final movieId = 550;
    final movieInfoModel =
        MovieInfoModel.fromJson(json.decode(fixture("movie.json")));

    test(
      "should perform GET request on a URL with id being at the endpoint",
      () {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getMovieById(movieId);
        // assert
        verify(mockHttpClient.get("https://api.themoviedb.org/3/movie/$movieId?api_key=$API_KEY"));
      },
    );

    test(
      "should return MovieInfo when the response code is 200 (success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getMovieById(movieId);
        // assert
        expect(result, equals(movieInfoModel));
      },
    );

    test(
      "should throw a ServerException when the response code is 404 or other",
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getMovieById;
        // assert
        expect(() => call(movieId), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group("getLatestMovie", () {
    final movieInfoModel =
        MovieInfoModel.fromJson(json.decode(fixture("movie.json")));

    test(
      "should perform GET request on a URL with latest being at the endpoint",
      () {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getLatestMovie();
        // assert
        verify(mockHttpClient.get("https://api.themoviedb.org/3/movie/latest?api_key=50991782afd87bf182e598cf8f7cb4d5"));
      },
    );

    test(
      "should return latest MovieInfo when the response code is 200 (success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getLatestMovie();
        // assert
        expect(result, equals(movieInfoModel));
      },
    );

    test(
      "should throw a ServerException when the response code is 404 or other",
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getLatestMovie;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
