import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/date_utils.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';
import 'package:movie_time/domain/core/short_actor_info.dart';
import 'package:movie_time/domain/series/short_season_info.dart';

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
  final List<ShortActorInfo> actors;
  final String latestEpisodeReleaseDate;
  final String nextEpisodeReleaseDate;
  final List<ShortSeasonInfo> seasons;

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
    @required this.seasons,
  });

  @override
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
        seasons,
      ];

  String get posterPathUrl => createSmallImageLink(posterPath);
  String get backdropPathUrl => createOriginalImageLink(backdropPath);
  String get genresString => "${genres.take(3).join(", ")}";
  String get releaseYearAndMonth => (releaseDate == "")
      ? "-"
      : "${releaseDate.substring(0, 4)} ${monthNumberAndName[releaseDate.substring(5, 7)]}";
  String get latestEpisodeReleaseDateString =>
      "${latestEpisodeReleaseDate.substring(0, 4)} ${monthNumberAndName[latestEpisodeReleaseDate.substring(5, 7)]} " +
      "${latestEpisodeReleaseDate.substring(latestEpisodeReleaseDate.length - 2)}";
  String get nextEpisodeReleaseDateString => (nextEpisodeReleaseDate != null)
      ? "${latestEpisodeReleaseDate.substring(0, 4)} ${monthNumberAndName[latestEpisodeReleaseDate.substring(5, 7)]} " +
          "${latestEpisodeReleaseDate.substring(latestEpisodeReleaseDate.length - 2)}"
      : "-";
}
