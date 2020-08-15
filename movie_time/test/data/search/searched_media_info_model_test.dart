import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/search/searched_media_info_model.dart';
import 'package:movie_time/domain/search/searched_media_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final searchMovieInfoModel = SearchedMediaInfoModel(
    title: "The Avengers",
    id: 24428,
    releaseYear: 2012,
    posterPath: "/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg",
    rating: 7.7,
    mediaType: MediaType.movie,
  );

  final searchSeriesInfoModel = SearchedMediaInfoModel(
    title: "Marvel's Avengers Assemble",
    id: 59427,
    releaseYear: 2013,
    posterPath: "/vchDkX1DtqTy3bIDJ7YqmSbX965.jpg",
    rating: 7.7,
    mediaType: MediaType.tv,
  );

  test(
    "should be a subclass of SearchedMediaInfo entity",
    () async {
      expect(searchMovieInfoModel, isA<SearchedMediaInfo>());
    },
  );

  test(
    "should return a valid movie model",
    () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("search_movie.json"));

      final result = SearchedMediaInfoModel.from(jsonMap);

      expect(result, searchMovieInfoModel);
    },
  );

  test("should return a valid series model", () async {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture("search_series.json"));

    final result = SearchedMediaInfoModel.from(jsonMap);

    expect(result, searchSeriesInfoModel);
  });
}
