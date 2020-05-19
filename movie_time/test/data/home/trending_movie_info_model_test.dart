import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/home/trending_movie_info_model.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  TrendingMovieInfoModel trendingMovieInfoModel = TrendingMovieInfoModel(
    id: 299536,
    title: "Avengers: Infinity War",
    genres: [GenreUtil.genreIdAndName[28]],
    posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
  );

  test("should be a subclass of TrendingMovieInfo entity", () {
    expect(trendingMovieInfoModel, isA<TrendingMovieInfo>());
  });

  test("should return a valid model", () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture("trending_movie.json"));
    
    final result = TrendingMovieInfoModel.fromJson(jsonMap);

    expect(result, trendingMovieInfoModel);
  });
}
