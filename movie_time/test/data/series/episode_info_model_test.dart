import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/series/episode_info_model.dart';
import 'package:movie_time/domain/series/episode_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final episodeInfoModel = EpisodeInfoModel(
    seasonNumber: 1,
    episodeNumber: 1,
    releaseDate: "2011-04-17",
    name: "Winter Is Coming",
    overview: "Jon Arryn, the Hand of the King, is dead.",
    backdropPath: "/wrGWeW4WKxnaeA8sxJb2T9O6ryo.jpg",
  );

  test(
    "should be a subclass of EpisodeInfo entity",
    () async {
      expect(episodeInfoModel, isA<EpisodeInfo>());
    },
  );

  test(
    "should return a valid model",
    () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("episode.json"));

      final result = EpisodeInfoModel.fromJson(jsonMap);

      expect(result, episodeInfoModel);
    },
  );
}
