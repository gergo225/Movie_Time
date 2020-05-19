import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MovieList<T> extends Equatable {
  final String listName;
  final List<T> movieList;

  MovieList({
    @required this.listName,
    @required this.movieList,
  });
}
