import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/short_actor_info_model.dart';
import 'package:movie_time/domain/series/series_info.dart';

import 'short_season_info_model.dart';

class SeriesInfoModel extends SeriesInfo {
  SeriesInfoModel({
    @required int id,
    @required String name,
    @required String overview,
    @required String releaseDate,
    @required double rating,
    @required List<String> genres,
    @required int episodeRuntimeInMinutes,
    @required String posterPath,
    @required String backdropPath,
    @required int seasonCount,
    @required String status,
    @required List<ShortActorInfoModel> actors,
    @required String latestEpisodeReleaseDate,
    @required String nextEpisodeReleaseDate,
    @required List<ShortSeasonInfoModel> seasons,
  }) : super(
          id: id,
          name: name,
          overview: overview,
          releaseDate: releaseDate,
          rating: rating,
          genres: genres,
          episodeRuntimeInMinutes: episodeRuntimeInMinutes,
          posterPath: posterPath,
          backdropPath: backdropPath,
          seasonCount: seasonCount,
          status: status,
          actors: actors,
          latestEpisodeReleaseDate: latestEpisodeReleaseDate,
          nextEpisodeReleaseDate: nextEpisodeReleaseDate,
          seasons: seasons,
        );

  factory SeriesInfoModel.fromJson(Map<String, dynamic> json) {
    return SeriesInfoModel(
      id: json["id"],
      actors: List<ShortActorInfoModel>.from(
        json["credits"]["cast"]
            .map((actorJson) => ShortActorInfoModel.from(actorJson)),
      ),
      backdropPath: json["backdrop_path"],
      episodeRuntimeInMinutes: json["episode_run_time"][0],
      genres: List<String>.from(
        json["genres"].map((genre) => genre["name"]),
      ),
      name: json["name"],
      latestEpisodeReleaseDate: json["last_air_date"],
      nextEpisodeReleaseDate: (json["next_episode_to_air"] != null)
          ? json["next_episode_to_air"]["air_date"]
          : null,
      overview: json["overview"],
      posterPath: json["poster_path"],
      rating: json["vote_average"],
      releaseDate: json["first_air_date"],
      seasonCount: json["number_of_seasons"],
      status: json["status"],
      seasons: List<ShortSeasonInfoModel>.from(
        json["seasons"].map(
          (seasonJson) => ShortSeasonInfoModel.fromJson(seasonJson),
        ),
      ),
    );
  }
}
