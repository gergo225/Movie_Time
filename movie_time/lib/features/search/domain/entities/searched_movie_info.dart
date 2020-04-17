import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_time/core/util/image_link_creator.dart';

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
  }) : super([title, id, releaseYear, posterPath, rating]);

  String get posterPathUrl => createImageLink(this.posterPath);
}
