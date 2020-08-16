import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/media_type.dart';
import 'package:movie_time/domain/search/searched_media_info.dart';

class SearchedMediaInfoModel extends SearchedMediaInfo {
  final String title;
  final int id;
  final int releaseYear;
  final String posterPath;
  final double rating;
  final MediaType mediaType;

  SearchedMediaInfoModel({
    @required this.title,
    @required this.id,
    @required this.releaseYear,
    @required this.posterPath,
    @required this.rating,
    @required this.mediaType,
  }) : super(
          title: title,
          id: id,
          releaseYear: releaseYear,
          posterPath: posterPath,
          rating: rating,
          mediaType: mediaType,
        );

  factory SearchedMediaInfoModel.from(Map<String, dynamic> json) {
    MediaType mediaType;
    if (json["media_type"] == "tv") {
      mediaType = MediaType.tv;
    } else if (json["media_type"] == "movie") {
      mediaType = MediaType.movie;
    }
    String releaseYear = mediaType == MediaType.tv
        ? json["first_air_date"]
        : json["release_date"];
    if (releaseYear == "") releaseYear = null;

    return SearchedMediaInfoModel(
      title: mediaType == MediaType.movie ? json["title"] : json["name"],
      id: json["id"],
      releaseYear: (releaseYear == null)
          ? null
          : int.parse(releaseYear.substring(0, 4)),
      posterPath: json["poster_path"],
      rating: json["vote_average"].toDouble(),
      mediaType: mediaType,
    );
  }
}
