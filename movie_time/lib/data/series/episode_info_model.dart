import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/series/episode_info.dart';

class EpisodeInfoModel extends EpisodeInfo {
  final String name;
  final int seasonNumber;
  final int episodeNumber;
  final String backdropPath;
  final String overview;
  final String releaseDate;

  EpisodeInfoModel({
    @required this.name,
    @required this.seasonNumber,
    @required this.episodeNumber,
    @required this.backdropPath,
    @required this.overview,
    @required this.releaseDate,
  }) : super(
    name: name,
    seasonNumber: seasonNumber,
    episodeNumber: episodeNumber,
    overview: overview,
    releaseDate: releaseDate,
    backdropPath: backdropPath,
  );

  factory EpisodeInfoModel.fromJson(Map<String, dynamic> json) {
    return EpisodeInfoModel(
      name: json["name"],
      releaseDate: json["air_date"],
      seasonNumber: json["season_number"],
      episodeNumber: json["episode_number"],
      backdropPath: json["still_path"],
      overview: json["overview"],
    );
  }
}