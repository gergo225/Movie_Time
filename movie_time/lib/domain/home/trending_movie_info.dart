import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

class TrendingMovieInfo extends Equatable {
  final int id;
  final String title;
  final List<String> genres;
  final String posterPath;

  TrendingMovieInfo({
    @required this.id,
    @required this.title,
    @required this.genres,
    @required this.posterPath,
  });

  @override
  List get props => [id, title, genres, posterPath];

  String get posterPathUrl => createPosterImageLink(posterPath);
  String get genresString => "${genres.take(3).join(", ")}";
}
