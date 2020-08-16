import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/home/short_media_info_model.dart';
import 'package:movie_time/domain/core/media_type.dart';
import 'package:movie_time/domain/home/short_media_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final shortMovieInfoModel = ShortMediaInfoModel(
    id: 338762,
    title: "Bloodshot",
    posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
    mediaType: MediaType.movie,
  );

  final shortSeriesInfoModel = ShortMediaInfoModel(
    id: 246,
    title: "Avatar: The Last Airbender",
    posterPath: "/42nUsJrcD4Us4SbILeYi7juBVJh.jpg",
    mediaType: MediaType.tv,
  );

  test("should be a subclass of ShortMediaInfo", () {
    expect(shortMovieInfoModel, isA<ShortMediaInfo>());
    expect(shortSeriesInfoModel, isA<ShortMediaInfo>());
  });

  test("should return a valid model for movies", () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture("short_movie.json"));

    final result = ShortMediaInfoModel.fromJson(jsonMap);

    expect(result, shortMovieInfoModel);
  });

  test("should return a valid model for series", () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture("short_series.json"));
    
    final result = ShortMediaInfoModel.fromJson(jsonMap);

    expect(result, shortSeriesInfoModel);
  });
}
