import 'package:flutter/foundation.dart';
import 'package:movie_time/data/core/short_actor_info_model.dart';
import 'package:movie_time/domain/movie/movie_info.dart';

class MovieInfoModel extends MovieInfo {
  final List<ShortActorInfoModel> actors;

  MovieInfoModel({
    @required String title,
    @required int id,
    @required String releaseDate,
    @required String overview,
    @required String backdropPath,
    @required String posterPath,
    @required double rating,
    @required int runtimeInMinutes,
    @required List<String> genres,
    @required this.actors,
    @required String trailerYouTubeKey,
  }) : super(
          title: title,
          id: id,
          releaseDate: releaseDate,
          overview: overview,
          backdropPath: backdropPath,
          posterPath: posterPath,
          rating: rating,
          runtimeInMinutes: runtimeInMinutes,
          genres: genres,
          actors: actors,
          trailerYouTubeKey: trailerYouTubeKey,
        );

  factory MovieInfoModel.fromJson(Map<String, dynamic> json) {
    return MovieInfoModel(
      title: json["title"],
      id: json["id"],
      releaseDate: json["release_date"],
      overview: json["overview"],
      backdropPath: json["backdrop_path"],
      posterPath: json["poster_path"],
      rating: json["vote_average"],
      runtimeInMinutes: json["runtime"],
      genres: List<String>.from(
        json["genres"].map((genre) => genre["name"]),
      ), // get only genre names as strings
      actors: List<ShortActorInfoModel>.from(
        json["credits"]["cast"]
            .map((actorJson) => ShortActorInfoModel.from(actorJson)),
      ),
      trailerYouTubeKey: (!json["videos"]["results"].isEmpty)
          ? json["videos"]["results"][0]["key"]
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "release_date": releaseDate,
      "overview": overview,
      "backdrop_path": backdropPath,
      "poster_path": posterPath,
      "vote_average": rating,
      "runtime": runtimeInMinutes,
      "genres": genres,
      "credits": {"cast": actors.map((actor) => actor.toJson())},
      "videos": {
        "results": [
          {"key": trailerYouTubeKey}
        ]
      },
    };
  }
}
