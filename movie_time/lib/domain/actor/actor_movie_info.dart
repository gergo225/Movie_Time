import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

class ActorMovieInfo extends Equatable {
  final int id;
  final String title;
  final String character;
  final String posterPath;

  ActorMovieInfo({
    @required this.id,
    @required this.title,
    @required this.character,
    @required this.posterPath,
  });

  String get posterPathUrl => createSmallImageLink(posterPath);

  @override
  List get props => [id, title, character, posterPath];
}
