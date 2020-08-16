import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';
import 'package:movie_time/domain/core/media_type.dart';

class ShortMediaInfo extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final MediaType mediaType;

  ShortMediaInfo({
    @required this.id,
    @required this.title,
    @required this.posterPath,
    @required this.mediaType,
  });

  @override
  List get props => [id, title, posterPath, mediaType];

  String get posterPathUrl => createLargeImageLink(posterPath);
}
