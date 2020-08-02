import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_time/data/movie/short_actor_info_model.dart';
import 'package:movie_time/data/series/series_info_model.dart';
import 'package:movie_time/domain/series/series_info.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final seriesInfoModel = SeriesInfoModel(
    name: "Game of Thrones",
    actors: [
      ShortActorInfoModel(
        id: 239019,
        character: "Jon Snow",
        name: "Kit Harington",
        profileImagePath: "/dwRmvQUkddCx6Xi7vDrdnQL4SJ0.jpg",
      ),
    ],
    backdropPath: "/gX8SYlnL9ZznfZwEH4KJUePBFUM.jpg",
    episodeRuntimeInMinutes: 60,
    genres: [
      "Sci-Fi & Fantasy",
      "Drama",
      "Action & Adventure",
    ],
    id: 1399,
    latestEpisodeReleaseDate: "2017-08-27",
    nextEpisodeReleaseDate: null,
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    posterPath: "/gwPSoYUHAKmdyVywgLpKKA4BjRr.jpg",
    rating: 8.2,
    releaseDate: "2011-04-17",
    seasonCount: 7,
    status: "Returning Series",
  );

  test(
    "should be a subclass of SeriesInfo entity",
    () async {
      expect(seriesInfoModel, isA<SeriesInfo>());
    },
  );

  test(
    "should return a valid model",
    () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture("series.json"));

      final result = SeriesInfoModel.fromJson(jsonMap);

      expect(result, seriesInfoModel);
    },
  );
}
