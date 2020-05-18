import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
}
