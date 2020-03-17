import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class MovieInfo extends Equatable {
  final String title;
  final int id;
  final String releaseDate;
  final String overview;

  MovieInfo({
    @required this.title,
    @required this.id,
    @required this.releaseDate,
    @required this.overview,
  }) : super([title, id, releaseDate, overview]);
}