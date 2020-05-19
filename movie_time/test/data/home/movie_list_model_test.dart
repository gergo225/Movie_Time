import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/home/movie_list_model.dart';
import 'package:movie_time/data/home/short_movie_info_model.dart';
import 'package:movie_time/data/home/trending_movie_info_model.dart';
import 'package:matcher/matcher.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final shortMovieInfoModel =
      ShortMovieInfoModel.fromJson(json.decode(fixture("short_movie.json")));

  final trendingMovieInfoModel = TrendingMovieInfoModel.fromJson(
      json.decode(fixture("trending_movie.json")));

  test("should get a ShortMovieInfoModel list ", () {
    final result = MovieListModel<ShortMovieInfoModel>.fromJson(
        json.decode(fixture("short_movie_list.json")), "Action", 10);

    final expectedListModel = MovieListModel<ShortMovieInfoModel>(
      listName: "Action",
      movieList: [shortMovieInfoModel],
    );
    // assert
    expect(result, equals(expectedListModel));
  });

  test("should get a TrendingMovieInfoModel list", () {
    final result = MovieListModel<TrendingMovieInfoModel>.fromJson(
        json.decode(fixture("trending_movie_list.json")), "Trending", 7);

    final expectedListModel = MovieListModel<TrendingMovieInfoModel>(
      listName: "Trending",
      movieList: [trendingMovieInfoModel],
    );
    // assert
    expect(result, expectedListModel);
  });

  test("should throw a TypeError when list with wrong generic is called", () {
    void callWithWrongType() {
      final result = MovieListModel<String>.fromJson(
        json.decode(fixture("trending_movie_list.json")), "Trending", 7);
    }
    
    expect(callWithWrongType, throwsA(TypeMatcher<TypeError>()));
  });
}
