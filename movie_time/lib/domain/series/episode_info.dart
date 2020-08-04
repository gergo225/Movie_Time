import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class EpisodeInfo extends Equatable {
  final int episodeNumber;
  final int seasonNumber;
  final String name;
  final String releaseDate;
  final String overview;
  final String backdropPath;

  EpisodeInfo({
    @required this.episodeNumber,
    @required this.seasonNumber,
    @required this.name,
    @required this.releaseDate,
    @required this.overview,
    @required this.backdropPath,
  });

  @override
  List<Object> get props => [
        episodeNumber,
        seasonNumber,
        name,
        releaseDate,
        overview,
        backdropPath,
      ];
}
