import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/home/short_movie_info_model.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final ShortMovieInfoModel shortMovieInfoModel = ShortMovieInfoModel(
    id: 338762,
    title: "Bloodshot",
    posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
  );

  test("should be a subclass of ShortMovieInfo", () {
    expect(shortMovieInfoModel, isA<ShortMovieInfo>());
  });

  test("should return a valid model", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("short_movie.json"));

    final result = ShortMovieInfoModel.fromJson(jsonMap);

    expect(result, shortMovieInfoModel);
  });

}
