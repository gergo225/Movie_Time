import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';

class ShortMovieInfoModel extends ShortMovieInfo {
  final int id;
  final String title;
  final String posterPath;

  ShortMovieInfoModel({
    @required this.id,
    @required this.title,
    @required this.posterPath,
  }) : super(
          id: id,
          title: title,
          posterPath: posterPath,
        );

  factory ShortMovieInfoModel.fromJson(Map<String, dynamic> json) {
    return ShortMovieInfoModel(
      id: json["id"],
      title: json["title"],
      posterPath: json["poster_path"],
    );
  }
}
