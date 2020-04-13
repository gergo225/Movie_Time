import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/features/search/data/models/searched_movie_info_model.dart';
import 'package:movie_time/features/search/domain/entities/searched_movie_info.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final searchMovieInfoModel = SearchedMovieInfoModel(
    title: "The Avengers",
    id: 24428,
    releaseYear: 2012,
    posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
    rating: 7.33,
  );

  test(
    "should be a subclass of SearchMovieInfo entity",
    () async {
      expect(searchMovieInfoModel, isA<SearchedMovieInfo>());
    },
  );

  test(
    "should return a valid model",
    () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("search_movie.json"));

      final result = SearchedMovieInfoModel.from(jsonMap);

      expect(result, searchMovieInfoModel);
    },
  );

  test(
    "should return a JSON map containing the proper data",
    () async {
      final result = searchMovieInfoModel.toJson();

      final expectedJsonMap = {
        "title": "The Avengers",
        "id": 24428,
        "release_date": "2012",
        "poster_path": "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
        "vote_average": 7.33
      };

      expect(result, expectedJsonMap);
    },
  );
}