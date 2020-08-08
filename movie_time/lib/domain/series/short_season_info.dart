import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

class ShortSeasonInfo extends Equatable {
  final int seasonNumber;
  final String name;
  final String posterPath;

  ShortSeasonInfo({
    @required this.seasonNumber,
    @required this.name,
    @required this.posterPath,
  });

  @override
  List<Object> get props => [seasonNumber, name, posterPath];

  String get posterPathUrl => createPosterImageLink(posterPath);
}
