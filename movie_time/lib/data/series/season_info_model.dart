import 'package:flutter/foundation.dart';
import 'package:movie_time/data/series/episode_info_model.dart';
import 'package:movie_time/domain/series/season_info.dart';

class SeasonInfoModel extends SeasonInfo {
  final String name;
  final String overview;
  final String posterPath;
  final int seasonEpisodeCount;
  final int seasonNumber;
  final String releaseDate;
  final List<EpisodeInfoModel> episodes;

  SeasonInfoModel({
    @required this.name,
    @required this.overview,
    @required this.posterPath,
    @required this.seasonEpisodeCount,
    @required this.seasonNumber,
    @required this.releaseDate,
    @required this.episodes,
  }) : super(
          name: name,
          overview: overview,
          posterPath: posterPath,
          seasonEpisodeCount: seasonEpisodeCount,
          seasonNumber: seasonNumber,
          releaseDate: releaseDate,
          episodes: episodes,
        );

  factory SeasonInfoModel.fromJson(Map<String, dynamic> json) {
    return SeasonInfoModel(
      name: json["name"],
      releaseDate: json["air_date"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      seasonNumber: json["season_number"],
      episodes: List<EpisodeInfoModel>.from(
        json["episodes"].map(
          (episodeJson) => EpisodeInfoModel.fromJson(episodeJson),
        ),
      ),
      seasonEpisodeCount: json["episodes"].length,
    );
  }
}
