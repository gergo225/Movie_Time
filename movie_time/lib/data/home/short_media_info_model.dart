import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/media_type.dart';
import 'package:movie_time/domain/home/short_media_info.dart';

class ShortMediaInfoModel extends ShortMediaInfo {
  final int id;
  final String title;
  final String posterPath;
  final MediaType mediaType;

  ShortMediaInfoModel({
    @required this.id,
    @required this.title,
    @required this.posterPath,
    @required this.mediaType,
  }) : super(
          id: id,
          title: title,
          posterPath: posterPath,
          mediaType: mediaType,
        );

  factory ShortMediaInfoModel.fromJson(Map<String, dynamic> json) {
    final mediaType = json["title"] != null ? MediaType.movie : MediaType.tv;
    final title = mediaType == MediaType.movie ? json["title"] : json["name"];

    return ShortMediaInfoModel(
      id: json["id"],
      title: title,
      posterPath: json["poster_path"],
      mediaType: mediaType,
    );
  }
}
