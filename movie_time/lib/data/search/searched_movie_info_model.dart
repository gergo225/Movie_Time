import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/search/searched_movie_info.dart';

class SearchedMovieInfoModel extends SearchedMovieInfo {
  final String title;
  final int id;
  final int releaseYear;
  final String posterPath;
  final double rating;

  SearchedMovieInfoModel({
    @required this.title,
    @required this.id,
    @required this.releaseYear,
    @required this.posterPath,
    @required this.rating,
  }) : super(
          title: title,
          id: id,
          releaseYear: releaseYear,
          posterPath: posterPath,
          rating: rating,
        );

  factory SearchedMovieInfoModel.from(Map<String, dynamic> json) {
    return SearchedMovieInfoModel(
      title: json["title"],
      id: json["id"],
      releaseYear: (json["release_date"] == "" || json["release_date"] == null)
          ? null
          : int.parse(json["release_date"].substring(0, 4)),
      posterPath: json["poster_path"],
      rating: json["vote_average"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "release_date": releaseYear.toString(),
      "poster_path": posterPath,
      "vote_average": rating,
    };
  }
}
