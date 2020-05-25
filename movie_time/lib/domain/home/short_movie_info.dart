import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

class ShortMovieInfo extends Equatable {
  final int id;
  final String title;
  final String posterPath;

  ShortMovieInfo({
    @required this.id,
    @required this.title,
    @required this.posterPath,
  });

  @override
  List get props => [id, title, posterPath];

  String get posterPathUrl => createPosterImageLink(posterPath);
}
