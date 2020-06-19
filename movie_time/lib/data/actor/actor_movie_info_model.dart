import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/actor/actor_movie_info.dart';

class ActorMovieInfoModel extends ActorMovieInfo {
  ActorMovieInfoModel({
    @required int id,
    @required String title,
    @required String character,
    @required String posterPath,
  }) : super(
          id: id,
          title: title,
          character: character,
          posterPath: posterPath,
        );

  factory ActorMovieInfoModel.fromJson(Map<String, dynamic> json) {
    return ActorMovieInfoModel(
      id: json["id"],
      title: json["title"],
      character: json["character"],
      posterPath: json["poster_path"],
    );
  }
}
