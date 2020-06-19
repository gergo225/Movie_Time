import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';
import 'package:movie_time/domain/core/date_utils.dart';
import 'package:movie_time/domain/movie/short_actor_info.dart';

class MovieInfo extends Equatable {
  final String title;
  final int id;
  final String releaseDate;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final double rating;
  final int runtimeInMinutes;
  final List<String> genres;
  final List<ShortActorInfo> actors;
  final String trailerYouTubeKey;

  MovieInfo({
    @required this.title,
    @required this.id,
    @required this.releaseDate,
    @required this.overview,
    @required this.backdropPath,
    @required this.posterPath,
    @required this.rating,
    @required this.runtimeInMinutes,
    @required this.genres,
    @required this.actors,
    @required this.trailerYouTubeKey,
  });

  String get posterPathUrl => createSmallImageLink(posterPath);
  String get bigPosterPathUrl => createPosterImageLink(posterPath);
  String get backdropPathUrl => createOriginalImageLink(backdropPath);
  String get runtimeInHoursAndMinutes =>
      "${runtimeInMinutes ~/ 60}h ${runtimeInMinutes % 60}min";
  String get genresString => "${genres.take(3).join(", ")}";
  String get releaseYearAndMonth => (releaseDate == "")
      ? "-"
      : "${releaseDate.substring(0, 4)} ${monthNumberAndName[releaseDate.substring(5, 7)]}";

  @override
  List get props => [
        title,
        id,
        releaseDate,
        overview,
        backdropPath,
        posterPath,
        rating,
        runtimeInMinutes,
        genres,
        actors,
        trailerYouTubeKey,
      ];
}
