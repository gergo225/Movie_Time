import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/home/movie_list_model.dart';
import 'package:movie_time/data/home/short_movie_info_model.dart';
import 'package:matcher/matcher.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final shortMovieInfoModel =
      ShortMovieInfoModel.fromJson(json.decode(fixture("short_movie.json")));

  final trendingMovieInfoModel = ShortMovieInfoModel.fromJson(
      json.decode(fixture("trending_movie.json")));

  test("should get a ShortMovieInfoModel list for a genre", () {
    final result = MovieListModel.fromJson(
        json.decode(fixture("short_movie_list.json")), "Action", 10);

    final expectedListModel = MovieListModel(
      listName: "Action",
      movieList: [shortMovieInfoModel],
    );
    // assert
    expect(result, equals(expectedListModel));
  });

  test("should get a ShortMovieInfoModel list for trending movies", () {
    final result = MovieListModel.fromJson(
        json.decode(fixture("trending_movie_list.json")), "Trending", 10);

    final expectedListModel = MovieListModel(
      listName: "Trending",
      movieList: [trendingMovieInfoModel],
    );
    // assert
    expect(result, expectedListModel);
  });
}
