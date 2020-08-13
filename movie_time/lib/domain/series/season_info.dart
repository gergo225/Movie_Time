import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

import 'episode_info.dart';

class SeasonInfo extends Equatable {
  final int seasonNumber;
  final int seasonEpisodeCount;
  final String name;
  final String overview;
  final String releaseDate;
  final List<EpisodeInfo> episodes;
  final String posterPath;

  SeasonInfo({
    @required this.seasonNumber,
    @required this.seasonEpisodeCount,
    @required this.name,
    @required this.overview,
    @required this.releaseDate,
    @required this.episodes,
    @required this.posterPath,
  });

  @override
  List<Object> get props => [
        seasonNumber,
        seasonEpisodeCount,
        name,
        overview,
        releaseDate,
        episodes,
        posterPath,
      ];

  String get posterPathUrl => createPosterImageLink(posterPath);
  String get releaseString => "${releaseDate.replaceAll("-", " ")}";
}
