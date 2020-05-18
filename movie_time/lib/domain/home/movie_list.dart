import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MovieList<Type> extends Equatable {
  final String listName;
  final List<Type> movieList;

  MovieList({
    @required this.listName,
    @required this.movieList,
  });
}
