import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/search/search_result_model.dart';
import 'package:movie_time/data/search/searched_media_info_model.dart';
import 'package:movie_time/domain/core/media_type.dart';
import 'package:movie_time/domain/search/search_result.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final searchResultModel = SearchResultModel(
    movies: [
      SearchedMediaInfoModel(
        title: "The Avengers",
        id: 24428,
        releaseYear: 2012,
        posterPath: "/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg",
        rating: 7.7,
        mediaType: MediaType.movie,
      ),
    ],
    series: [
      SearchedMediaInfoModel(
        title: "Marvel's Avengers Assemble",
        id: 59427,
        releaseYear: 2013,
        posterPath: "/vchDkX1DtqTy3bIDJ7YqmSbX965.jpg",
        rating: 7.7,
        mediaType: MediaType.tv,
      ),
    ],
  );

  test(
    "should be a subclass of SearchResult entity",
    () async {
      expect(searchResultModel, isA<SearchResult>());
    },
  );

  test(
    "should return a valid model",
    () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("search_result.json"));

      final result = SearchResultModel.from(jsonMap);

      expect(result, searchResultModel);
    },
  );
}
