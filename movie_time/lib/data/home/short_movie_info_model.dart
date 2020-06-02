import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';

class ShortMovieInfoModel extends ShortMovieInfo {
  final int id;
  final String title;
  final List<String> genres;
  final String posterPath;

  ShortMovieInfoModel({
    @required this.id,
    @required this.title,
    @required this.genres,
    @required this.posterPath,
  }) : super(
          id: id,
          title: title,
          genres: genres,
          posterPath: posterPath,
        );

  factory ShortMovieInfoModel.fromJson(Map<String, dynamic> json) {
    return ShortMovieInfoModel(
      id: json["id"],
      title: json["title"],
      genres: List<String>.from(
        json["genre_ids"].map((genreId) => GenreUtil.genreIdAndName[genreId]),
      ),
      posterPath: json["poster_path"],
    );
  }
}
