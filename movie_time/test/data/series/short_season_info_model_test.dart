import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/series/short_season_info_model.dart';
import 'package:movie_time/domain/series/short_season_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final shortSeasonInfoModel = ShortSeasonInfoModel(
    name: "Season 1",
    posterPath: "/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg",
  );

  test(
    "should be a subclass of ShortSeasonInfo entity",
    () async {
      expect(shortSeasonInfoModel, isA<ShortSeasonInfo>());
    },
  );

  test(
    "should return a valid model",
    () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("short_season.json"));

      final result = ShortSeasonInfoModel.fromJson(jsonMap);

      expect(result, shortSeasonInfoModel);
    },
  );
}
