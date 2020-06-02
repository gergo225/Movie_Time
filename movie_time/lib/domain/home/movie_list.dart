import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/home/short_movie_info.dart';

class MovieList extends Equatable {
  final String listName;
  final List<ShortMovieInfo> movieList;

  MovieList({
    @required this.listName,
    @required this.movieList,
  });
}
