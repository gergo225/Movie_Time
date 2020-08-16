import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/home/media_list_model.dart';
import 'package:movie_time/data/home/short_media_info_model.dart';
import 'package:matcher/matcher.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final shortMovieInfoModel =
      ShortMediaInfoModel.fromJson(json.decode(fixture("short_movie.json")));

  final trendingMovieInfoModel =
      ShortMediaInfoModel.fromJson(json.decode(fixture("trending_movie.json")));

  final shortSeriesInfoModel =
      ShortMediaInfoModel.fromJson(json.decode(fixture("short_series.json")));

  final trendingSeriesInfoModel =
      ShortMediaInfoModel.fromJson(json.decode(fixture("trending_series.json")));

  test("should get a ShortMediaInfoModel list of movies for a genre", () {
    final result = MediaListModel.fromJson(
        json.decode(fixture("short_movie_list.json")), "Action", 10);

    final expectedListModel = MediaListModel(
      listName: "Action",
      mediaList: [shortMovieInfoModel],
    );
    // assert
    expect(result, equals(expectedListModel));
  });

  test("should get a ShortMediaInfoModel list for trending movies", () {
    final result = MediaListModel.fromJson(
        json.decode(fixture("trending_movie_list.json")), "Trending", 10);

    final expectedListModel = MediaListModel(
      listName: "Trending",
      mediaList: [trendingMovieInfoModel],
    );
    // assert
    expect(result, expectedListModel);
  });
  
  test("should get a ShortMediaInfoModel list of series for a genre", () {
    final result = MediaListModel.fromJson(
        json.decode(fixture("short_series_list.json")), "Action", 10);

    final expectedListModel = MediaListModel(
      listName: "Action",
      mediaList: [shortSeriesInfoModel],
    );
    // assert
    expect(result, equals(expectedListModel));
  });

  test("should get a ShortMeidaInfoModel list for trending series", () {
    final result = MediaListModel.fromJson(
        json.decode(fixture("trending_series_list.json")), "Trending", 10);

    final expectedListModel = MediaListModel(
      listName: "Trending",
      mediaList: [trendingSeriesInfoModel],
    );
    // assert
    expect(result, expectedListModel);
  });
}
