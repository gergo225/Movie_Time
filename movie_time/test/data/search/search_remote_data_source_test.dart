import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:movie_time/data/search/search_remote_data_source.dart';
import 'package:movie_time/data/search/search_result_model.dart';
import 'package:matcher/matcher.dart';

import '../../fixtures/fixture_reader.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  SearchRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SearchRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture("search_result.json"), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));
  }

  group("searchMovieByTitle", () {
    final movieTitle = "Avengers";
    final searchResultModel =
        SearchResultModel.from(json.decode(fixture("search_result.json")));

    test(
        "should perform GET request on a URL with 'title' being at the endponint",
        () {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.searchMovieByTitle(movieTitle);
      // assert
      verify(mockHttpClient.get(
          "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&language=en-US&query=$movieTitle&page=1"));
    });

    test(
      "should return SearchResult when the response code is 200(success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.searchMovieByTitle(movieTitle);
        // assert
        expect(result, equals(searchResultModel));
      },
    );

    test("should throw a ServerException when the response code is 404 or other", () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.searchMovieByTitle;
      // assert
      expect(() => call(movieTitle), throwsA(TypeMatcher<ServerException>()));
    });

  });
}
