import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/genre_utils.dart';
import 'package:movie_time/domain/home/trending_movie_info.dart';

class TrendingMovieInfoModel extends TrendingMovieInfo {
  final int id;
  final String title;
  final List<String> genres;
  final String posterPath;

  TrendingMovieInfoModel({
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

  factory TrendingMovieInfoModel.fromJson(Map<String, dynamic> json) {
    return TrendingMovieInfoModel(
      id: json["id"],
      title: json["title"],
      genres: List<String>.from(
        json["genre_ids"].map((genreId) => GenreUtil.genreIdAndName[genreId]),
      ),
      posterPath: json["poster_path"],
    );
  }
}
