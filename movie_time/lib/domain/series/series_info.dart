import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/actor/actor_info.dart';

class SeriesInfo extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String releaseDate;
  final double rating;
  final List<String> genres;
  final int episodeRuntimeInMinutes;
  final String posterPath;
  final String backdropPath;
  final int seasonCount;
  final String status;
  final List<ActorInfo> actors;
  final String latestEpisodeReleaseDate;
  final String nextEpisodeReleaseDate;

  SeriesInfo({
    @required this.id,
    @required this.name,
    @required this.overview,
    @required this.releaseDate,
    @required this.rating,
    @required this.genres,
    @required this.episodeRuntimeInMinutes,
    @required this.posterPath,
    @required this.backdropPath,
    @required this.seasonCount,
    @required this.status,
    @required this.actors,
    @required this.latestEpisodeReleaseDate,
    @required this.nextEpisodeReleaseDate,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        name,
        overview,
        releaseDate,
        rating,
        genres,
        episodeRuntimeInMinutes,
        posterPath,
        backdropPath,
        seasonCount,
        status,
        actors,
        latestEpisodeReleaseDate,
        nextEpisodeReleaseDate,
      ];
}
