import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_time/domain/core/image_link_creator.dart';

class SearchedMovieInfo extends Equatable {
  final String title;
  final int id;
  final int releaseYear;
  final String posterPath;
  final double rating;

  SearchedMovieInfo({
    @required this.title,
    @required this.id,
    @required this.releaseYear,
    @required this.posterPath,
    @required this.rating,
  });

  String get posterPathUrl => createSmallImageLink(posterPath);
  String get releaseYearString => (releaseYear != null) ? "$releaseYear" : "-";

  @override
  List get props => [title, id, releaseYear, posterPath, rating];
}
