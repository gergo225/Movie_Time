import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/series/episode_info_model.dart';
import 'package:movie_time/data/series/season_info_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final seasonInfoModel = SeasonInfoModel(
    name: "Season 1",
    seasonNumber: 1,
    overview: "Trouble is brewing in the Seven Kingdoms of Westeros.",
    releaseDate: "2011-04-17",
    posterPath: "/olJ6ivXxCMq3cfujo1IRw30OrsQ.jpg",
    seasonEpisodeCount: 1,
    episodes: [
      EpisodeInfoModel(
        seasonNumber: 1,
        episodeNumber: 1,
        releaseDate: "2011-04-17",
        name: "Winter Is Coming",
        overview: "Jon Arryn, the Hand of the King, is dead.",
        backdropPath: "/wrGWeW4WKxnaeA8sxJb2T9O6ryo.jpg",
      ),
    ],
  );

  test(
    "should be a subclass of SeasonInfo entity",
    () async {
      expect(seasonInfoModel, isA<SeasonInfoModel>());
    },
  );

  test(
    "should return a valid model",
    () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("season.json"));

      final result = SeasonInfoModel.fromJson(jsonMap);

      expect(result, seasonInfoModel);
    },
  );
}
