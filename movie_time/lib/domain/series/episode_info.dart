import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

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

  String get backdropPathUrl => createOriginalImageLink(backdropPath);
  String get nameWithNumber => "$episodeNumber. $name";
}
