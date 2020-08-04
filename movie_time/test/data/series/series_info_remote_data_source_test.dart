import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_time/data/core/api_key.dart';
import 'package:movie_time/data/core/exception.dart';
import 'package:matcher/matcher.dart';
import 'package:movie_time/data/series/season_info_model.dart';
import 'package:movie_time/data/series/series_info_model.dart';
import 'package:movie_time/data/series/series_info_remote_data_source.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  SeriesInfoRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesInfoRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String fixtureFile) {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(fixture(fixtureFile), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response("Somethings went wrong", 404));
  }

  group("getSeriesById", () {
    final fixtureName = "series.json";
    final seriesId = 1399;
    final seriesInfoModel =
        SeriesInfoModel.fromJson(json.decode(fixture(fixtureName)));

    test(
      "should perform GET request on a URL with id being at the endpoint",
      () {
        // arrange
        setUpMockHttpClientSuccess200(fixtureName);
        // act
        dataSource.getSeriesById(seriesId);
        // assert
        verify(mockHttpClient.get(
            "https://api.themoviedb.org/3/tv/$seriesId?api_key=$API_KEY&append_to_response=credits"));
      },
    );

    test(
      "should return SeriesInfo when the response code is 200 (success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200(fixtureName);
        // act
        final result = await dataSource.getSeriesById(seriesId);
        // assert
        expect(result, equals(seriesInfoModel));
      },
    );

    test(
      "should throw a ServerException when the response code is 404 or other",
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getSeriesById;
        // assert
        expect(() => call(seriesId), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group("getSeriesSeasonByNumber", () {
    final fixtureName = "season.json";
    final seriesId = 1399;
    final seasonNumber = 1;
    final seriesInfoModel =
        SeasonInfoModel.fromJson(json.decode(fixture(fixtureName)));

    test(
      "should perform GET request on a URL with id being at the endpoint",
      () {
        // arrange
        setUpMockHttpClientSuccess200(fixtureName);
        // act
        dataSource.getSeriesSeasonByNumber(seriesId, seasonNumber);
        // assert
        verify(mockHttpClient.get(
            "https://api.themoviedb.org/3/tv/$seriesId/season/$seasonNumber?api_key=$API_KEY"));
      },
    );

    test(
      "should return SeasonInfo when the response code is 200 (success)",
      () async {
        // arrange
        setUpMockHttpClientSuccess200(fixtureName);
        // act
        final result = await dataSource.getSeriesSeasonByNumber(seriesId, seasonNumber);
        // assert
        expect(result, equals(seriesInfoModel));
      },
    );

    test(
      "should throw a ServerException when the response code is 404 or other",
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getSeriesSeasonByNumber;
        // assert
        expect(() => call(seriesId, seasonNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
